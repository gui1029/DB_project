/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.DAO;
import dao.DAOFactory;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Car;
import model.Carteira;
import model.Pagamento;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author mathe
 */
@WebServlet(
        name = "CarteiraController",
        urlPatterns = {
            "/carteira/update",
            "/carteira/alugar",
            "/carteira/devolver",
        })
public class CarteiraController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher; 
        
        switch (request.getServletPath()) {
            case "/carteira/update":
                dispatcher = request.getRequestDispatcher("/view/carteira/update.jsp");
                dispatcher.forward(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO<Carteira, String> dao;
        DAO<Car, String> dao2;
        DAO<Pagamento, ArrayList<String>> pagdao;
        Carteira carteira1 = new Carteira();
        Carteira carteira2;
        Pagamento pagamento = new Pagamento();
        HttpSession session = request.getSession();

        String servletPath = request.getServletPath();

        switch (request.getServletPath()) {
            
            case "/carteira/alugar": {
                System.out.println("ALOOOOOOOOOO\n\n\n");
                // Se fosse um form simples, usaria request.getParameter()
                // String login = request.getParameter("login");

                // Manipulação de form com enctype="multipart/form-data"
                // Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Set the directory used to temporarily store files that are larger than the configured size threshold
                factory.setRepository(new File("/tmp"));
                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);

                try ( DAOFactory daoFactory = DAOFactory.getInstance()) {
                    // Parse the request
                    Car carro = new Car();
                    dao = daoFactory.getCarteiraDAO();
                    dao2 = daoFactory.getCarDAO();
                    pagdao = daoFactory.getPagamentoDAO();
                    
                    carteira1 = dao.read(request.getParameter("cpf_locador"));
                    carteira2 = dao.read(request.getParameter("cpf_locatario"));

                    carteira1.setSaldo(carteira1.getSaldo() + Double.parseDouble(request.getParameter("preco")));
                    carteira2.setSaldo(carteira2.getSaldo() - Double.parseDouble(request.getParameter("preco")));
                    
                    carro.setCpf_locador(request.getParameter("cpf_locador"));
                    carro.setAbss(Boolean.parseBoolean(request.getParameter("abss")));
                    carro.setNum_lugares(Integer.parseInt(request.getParameter("num_lugares")));
                    carro.setPlaca(request.getParameter("placa"));
                    carro.setModelo(request.getParameter("modelo"));
                    carro.setTipo(request.getParameter("tipo"));
                    carro.setAr_condicionado(Boolean.parseBoolean(request.getParameter("ar_condicionado")));
                    carro.setAirbags(Boolean.parseBoolean(request.getParameter("airbags")));
                    carro.setDescricao(request.getParameter("descricao"));
                    carro.setDisponibilidade(false);
                    carro.setCpf_locador(request.getParameter("cpf_locador"));
                    carro.setAno(Integer.parseInt(request.getParameter("ano")));
                    carro.setPreco(Double.parseDouble(request.getParameter("preco")));
                    
                    pagamento.setCpf_locador(request.getParameter("cpf_locador"));
                    pagamento.setCpf_locatario(request.getParameter("cpf_locatario"));
                    pagamento.setData_devolucao(null);
                    pagamento.setData_pagamento(new Date(System.currentTimeMillis()));
                    pagamento.setNum_placa_carro(request.getParameter("placa"));
                    pagamento.setValor(Double.parseDouble(request.getParameter("preco")));
                    
                    servletPath += "?cpf_locador=" + String.valueOf(carteira1.getCpf()) + "&saldo_locador=" + 700 + "&cpf_locatario=" + String.valueOf(carteira2.getCpf()) +"&saldo_locatario=" + 200;
                    dao.update(carteira1);
                    dao.update(carteira2);
                    session.setAttribute("carteira", carteira2);
                    dao2.update(carro);
                    pagdao.create(pagamento);
                    

                    response.sendRedirect(request.getContextPath() + "/fluxo/grid");
                    
                }  catch (ClassNotFoundException | IOException | SQLException ex) {
                    Logger.getLogger(CarController.class.getName()).log(Level.SEVERE, "Controller", ex);
                    session.setAttribute("error", ex.getMessage());
                    response.sendRedirect(request.getContextPath() + servletPath);
                } catch (Exception ex) {
                    Logger.getLogger(CarteiraController.class.getName()).log(Level.SEVERE, "Controller", ex);
                    session.setAttribute("error", "Erro ao gravar arquivo no servidor.");
                    response.sendRedirect(request.getContextPath() + servletPath);
                }
                break;
            }
            
            case "/carteira/devolver": {
                // Se fosse um form simples, usaria request.getParameter()
                // String login = request.getParameter("login");

                // Manipulação de form com enctype="multipart/form-data"
                // Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Set the directory used to temporarily store files that are larger than the configured size threshold
                factory.setRepository(new File("/tmp"));
                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);

                try ( DAOFactory daoFactory = DAOFactory.getInstance()) {
                    // Parse the request
                    Car carro;
                    ArrayList<String> keys = new ArrayList<>();
                    dao2 = daoFactory.getCarDAO();
                    pagdao = daoFactory.getPagamentoDAO();
                    
                    
                    keys.add(request.getParameter("placa"));
                    keys.add(request.getParameter("cpf_locador"));
                    keys.add(request.getParameter("cpf_locatario"));
                    
                    pagamento = pagdao.read(keys);
                    pagamento.setData_devolucao(new Date(System.currentTimeMillis()));                    

                    carro = dao2.read(request.getParameter("placa"));
                    carro.setDisponibilidade(true);
                    
                    
                    servletPath += "?cpf_locador=" + String.valueOf(pagamento.getCpf_locador());
                    pagdao.update(pagamento);
                    dao2.update(carro);

                    response.sendRedirect(request.getContextPath() + "/fluxo/profile");
                    
                }  catch (ClassNotFoundException | IOException | SQLException ex) {
                    Logger.getLogger(CarController.class.getName()).log(Level.SEVERE, "Controller", ex);
                    session.setAttribute("error", ex.getMessage());
                    response.sendRedirect(request.getContextPath() + servletPath);
                } catch (Exception ex) {
                    Logger.getLogger(CarteiraController.class.getName()).log(Level.SEVERE, "Controller", ex);
                    session.setAttribute("error", "Erro ao gravar arquivo no servidor.");
                    response.sendRedirect(request.getContextPath() + servletPath);
                }
                break;
            }
           
            
            case "/carteira/update": {
                // Se fosse um form simples, usaria request.getParameter()
                // String login = request.getParameter("login");

                // Manipulação de form com enctype="multipart/form-data"
                // Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // Set the directory used to temporarily store files that are larger than the configured size threshold
                factory.setRepository(new File("/tmp"));
                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);

                try ( DAOFactory daoFactory = DAOFactory.getInstance()) {
                    // Parse the request
                    List<FileItem> items = upload.parseRequest(request);

                    // Process the uploaded items
                    Iterator<FileItem> iter = items.iterator();
                    while (iter.hasNext()) {
                        FileItem item = iter.next();

                        // Process a regular form field
                        if (item.isFormField()) {
                            String fieldName = item.getFieldName();
                            String fieldValue = item.getString();

                            switch (fieldName) {
                                case "cpf":
                                    carteira1.setCpf(fieldValue);
                                    break;
                                case "valor":
                                    carteira1.setSaldo(Double.parseDouble(fieldValue) +((Carteira)(session.getAttribute("carteira"))).getSaldo());
                                    break;
                            }
                        } 
                    }

                    dao = daoFactory.getCarteiraDAO();

                        servletPath += "?cpf=" + String.valueOf(carteira1.getCpf());
                        dao.update(carteira1);
                        session.setAttribute("carteira", carteira1);
                    response.sendRedirect(request.getContextPath() + "/fluxo/profile");
                    
                } catch (ClassNotFoundException | IOException | SQLException ex) {
                    Logger.getLogger(CarteiraController.class.getName()).log(Level.SEVERE, "Controller", ex);
                    session.setAttribute("error", ex.getMessage());
                    response.sendRedirect(request.getContextPath() + servletPath);
                } catch (Exception ex) {
                    Logger.getLogger(CarteiraController.class.getName()).log(Level.SEVERE, "Controller", ex);
                    session.setAttribute("error", "Erro ao gravar arquivo no servidor.");
                    response.sendRedirect(request.getContextPath() + servletPath);
                }
                break;
            }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */

}}
