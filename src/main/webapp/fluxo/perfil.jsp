<%-- 
    Document   : perfil
    Created on : 9 de dez. de 2020, 20:46:43
    Author     : mathe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib tagdir="/WEB-INF/tags/session" prefix="session"%>
<session:my_user context="${pageContext.servletContext.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Harrier Car Detail Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Default Description">
<meta name="keywords" content="fashion, store, E-commerce">
<meta name="robots" content="*">
<link rel="icon" href="#" type="image/x-icon">
<link rel="shortcut icon" href="#" type="image/x-icon">

<!-- CSS Style -->
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/font-awesome.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/bootstrap-select.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/revslider.css" >
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/owl.theme.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/jquery.bxslider.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/jquery.mobile-menu.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/style.css" media="all">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/stylesheet/responsive.css" media="all">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,700italic,400,600,700,800' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Saira+Condensed:300,400,500,600,700,800" rel="stylesheet">
</head>
<body>
    <c:set var='nome_p' value="${sessionScope.usuario.nome}" />
    <c:set var='avatar_p' value="${sessionScope.usuario.avatar}" />
    <c:set var='cpf_p' value="${sessionScope.usuario.cpf}" />
    <c:set var='saldo_c' value="${sessionScope.carteira.saldo}" />
    <c:set var='trigger_1' value="1" />
<div id="page">
  <header>
    <div class="container">
      <head>
      <%@include file="/header_footer/head.jsp"%>
      <title>[BD 2020] Carros</title>
      </head>
    </div>
  </header>
  <div class="page-heading">
    <div class="breadcrumbs">
      <div class="container">
        <!--row--> 
      </div>
      <!--container--> 
    </div>
    <div class="page-title">
      <h2>Perfil</h2>
    </div>
  </div>
  <!-- BEGIN Main Container -->
  <div class="main-container col1-layout wow bounceInUp animated">
    <div class="main">
      <div class="col-main"> 
        <!-- Endif Next Previous Product -->
        <div class="product-view wow bounceInUp animated" itemscope="" itemtype="http://schema.org/Product" itemid="#product_base">
          <div id="messages_product_view"></div>
          <!--product-next-prev-->
          <div class="product-essential container">
            <div class="row">
              <form action="#" method="post" id="product_addtocart_form">
                <!--End For version 1, 2, 6 --> 
                <!-- For version 3 -->
                <div class="product-img-box col-lg-5 col-sm-5 col-xs-12">
                  <div class="new-label new-top-left">Hot</div>
                  <div class="sale-label sale-top-left">-15%</div>
                  <div class="product-image">
                    <div class="product-full"><img id="product-zoom1" src="${pageContext.request.contextPath}/img/<c:if test="${avatar_p == null}">default_avatar.png</c:if><c:if test="${avatar_p != null}">${avatar_p}</c:if>" data-zoom-image="${pageContext.request.contextPath}/img/<c:if test="${avatar_p == null}">default_avatar.png</c:if><c:if test="${avatar_p != null}">${avatar_p}</c:if>" alt="product-image"/> </div>
                  </div>
                </div>
                <!--End For version 1,2,6--> 
                <!-- For version 3 -->
                <div class="product-shop col-lg- col-sm-7 col-xs-12">
                  <div class="product-name">
                    <h1>${nome_p} </h1>
                  </div>
                   <c:forEach var="locador" items="${requestScope.locadorList}">
                  <c:if test="${cpf_p == locador.cpf_pessoa}">
                      <c:set var='trigger_1' value="0" />
                  </c:if>
                   </c:forEach>
                   <c:if test="${trigger_1 == 1}">
                  <button class="button " title="Add to Cart" type="button" display="inline"><a href="${pageContext.servletContext.contextPath}/locador/create?cpf=${cpf_p}">  Se tornar um Locador  </a></button><br/><br/>
                   </c:if>
                  <button class="button " title="Add to Cart" type="button" display="inline"><a href="${pageContext.servletContext.contextPath}/pessoa/update?cpf=${cpf_p}">  Editar  </a></button><br/><br/>
                    <button class="button newbutton" title="Creditar" type="button"><a href="${pageContext.servletContext.contextPath}/carteira/update"><span>  Creditar carteira  </span></a></button><br/><br/>
                    <c:if test="${trigger_1 == 0}">
                    <button class="button " title="Add to Cart" type="button"><a href="${pageContext.servletContext.contextPath}/car/create?cpf=${cpf_p}">  Postar carro  </a> </button>
                    </c:if>
                    <div class="woocommerce-Reviews">
                        <h2>Creditos Restantes: $${saldo_c}</h2>
                    </div>
                    
                </div>
                <!--product-shop--> 
                <!--Detail page static block for version 3-->
              </form>
            </div>
          </div>
          <!--product-essential-->
          <div class="product-collateral container">
            <div id="productTabContent" class="tab-content">
              <!--<div class="tab-pane fade" id="product_tabs_tags">-->
              <div>
                  <c:forEach var="locador" items="${requestScope.locadorList}">
                  <c:if test="${cpf_p == locador.cpf_pessoa}">
                  <div>
                    <h2 class="woocommerce-Reviews-title"> Lista de carros postados: </h2>
                  </div>
                  <div class="category-products">
                    <ol class="products-list" id="products-list">
                        <c:forEach var="carro" items="${requestScope.carList}">
                            <c:if test="${cpf_p == carro.cpf_locador}">
                                <li class="item even">
                                    <div class="product-image"> <a href="${pageContext.servletContext.contextPath}/fluxo/detail?placa=${carro.placa}" title="HTC Rhyme Sense"> <img class="small-image" src="${pageContext.request.contextPath}/img/<c:if test="${carro.avatar == null}">default_avatar.png</c:if><c:if test="${carro.avatar != null}">${carro.avatar}</c:if>" alt="HTC Rhyme Sense"> </a> </div>
                                    <div class="product-shop">
                                        <h2 class="product-name"><a href="${pageContext.servletContext.contextPath}/fluxo/detail?placa=${carro.placa}" title="HTC Rhyme Sense">${carro.modelo} <br/> Ano: ${carro.ano}</a></h2>
                                    <div class="desc std">
                                    <c:if test="${carro.disponibilidade == false}"> <div class="new-label"> Used </div> </c:if>
                                    <br>
                                    <br>
                                    <p> ${carro.descricao} </p>
                                    </div>
                                    <div class="price-box">
                                    <p class="special-price"> <span class="price-label"></span> <span id="product-price-212" class="price"> $${carro.preco} </span> </p>
                                    </div>
                                    <div class="actions">
                                    <button class="button" title="Editar" type="button"><a href="${pageContext.servletContext.contextPath}/car/update?placa=${carro.placa}">Editar</a></button>
                                    <button class="button" title="Excluir" type="button"><a href="${pageContext.servletContext.contextPath}/car/delete?placa=${carro.placa}">Excluir</a></button>
                                    </div>
                                    </div>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ol>
                </div>
                 </c:if>
                  </c:forEach>
              </div>
              <br/>
              <br/>
            </div>
               <div class="product-collateral container">
            <div id="productTabContent" class="tab-content">
              <div>
                    <h2 class="woocommerce-Reviews-title"> Lista de carros Alugados: </h2>
                  </div>
                <div class="category-products">
                    <ol class="products-list" id="products-list">
              <c:forEach var="carro" items="${requestScope.carList}">
                  <c:forEach var="pagamento" items="${requestScope.pagamentoList}">
                       <c:if test="${null == pagamento.data_devolucao}">
                       <c:if test="${carro.placa == pagamento.num_placa_carro}">
                            <c:if test="${cpf_p == pagamento.cpf_locatario}">
                                <li class="item even">
                                    <div class="product-image"> <a href="${pageContext.servletContext.contextPath}/fluxo/detail?placa=${carro.placa}" title="HTC Rhyme Sense"> <img class="small-image" src="${pageContext.request.contextPath}/img/<c:if test="${carro.avatar == null}">default_avatar.png</c:if><c:if test="${carro.avatar != null}">${carro.avatar}</c:if>" alt="HTC Rhyme Sense"> </a> </div>
                                    <div class="product-shop">
                                        <h2 class="product-name"><a href="${pageContext.servletContext.contextPath}/fluxo/detail?placa=${carro.placa}" title="HTC Rhyme Sense">${carro.modelo} <br/> Ano: ${carro.ano}</a></h2>
                                    <div class="desc std">
                                    <c:if test="${carro.disponibilidade == false}"> <div class="new-label"> Used </div> </c:if>
                                    <br>
                                    <br>
                                    <p> ${carro.descricao} </p>
                                    </div>
                                    <div class="price-box">
                                    <p class="special-price"> <span class="price-label"></span> <span id="product-price-212" class="price"> $${carro.preco} </span> </p>
                                    </div>
                                    <div class="actions">
                                    <form action="${pageContext.servletContext.contextPath}/carteira/devolver" method="post">
                                        <input type="hidden" name="placa" value="${carro.placa}"/>
                                        <input type="hidden" name="cpf_locador" value="${carro.cpf_locador}"/>
                                        <input type="hidden" name="cpf_locatario" value="${sessionScope.usuario.cpf}"/>
                                        <input class="button" title="Devolver" type="submit" value="Devolver"> 
                                    </form>
                                    </div>
                                    </div>
                                </li>
                            </c:if>
                       </c:if>
                </c:if>
                          </c:forEach>
                        </c:forEach>
                                </ol>
                </div>
            </div>
                   </div>
          </div>
          <!-- end related product --> 
        </div>
        <!--box-additional--> 
        <!--product-view--> 
      </div>
    </div>
    <!--col-main--> 
  </div>
  <!--main-container--> 
</div>
<!--col1-layout--> 
<!-- End For version 1,2,3,4,6 -->

 <footer> 
    <div class="container">
      <head>
      <%@include file="/header_footer/foot.jsp"%>
      <title>[BD 2020] Carros</title>
    </div>
  </footer>
<!--page--> 

<div id="fade"></div>

<!-- JavaScript --> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script> 
<script src="${pageContext.servletContext.contextPath}/js/bootstrap-slider.min.js"></script> 
<script src="${pageContext.servletContext.contextPath}/js/bootstrap-select.min.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/parallax.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/revslider.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/common.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/jquery.bxslider.min.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/owl.carousel.min.js"></script> 
<script src="${pageContext.servletContext.contextPath}/js/cloud-zoom.js"></script> 
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/jquery.mobile-menu.min.js"></script> 
<script type="text/javascript">
    function HideMe()
    {
        jQuery('.popup1').hide();
        jQuery('#fade').hide();
	
		
    }
	function ShowMe()
    {
        jQuery('.popup2').show();
        jQuery('#fade').show();
		
    }
		function ShowMe1()
    {
        jQuery('.popup3').show();
        jQuery('#fade').show();
		
    }
	function HideMe1()
    {
        jQuery('.popup2').hide();
        jQuery('#fade').hide();

		
    }
	
		function HideMe2()
    {
        jQuery('.popup3').hide();
        jQuery('#fade').hide();

		
    }
</script>

</body>

</html>

