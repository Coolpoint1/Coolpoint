<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@ page import ="com.onlinecloth.pojo.*"%>
    <%@ page import ="com.onlinecloth.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Order Cold-Drink & water</title>
<%@ include file="components/common_cs_js.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="css/style1.css"> 
</head>
<body>
<%@ include file="components/navbar.jsp"%>
    
    <%
         String searchResult=(String)request.getAttribute("enteredText");
         String prodFor=(String)request.getAttribute("prodFor");
         String bId=(String)request.getAttribute("bId");
         String cId=(String)request.getAttribute("cId");
         String prodRange=(String)request.getAttribute("prodRange");
         String cat=request.getParameter("category"); 
         String cloId=request.getParameter("cloth"); 
         ProductDaoImp pdao=new ProductDaoImp();
         BrandDaoImp cdao1=new BrandDaoImp();
         List<Product> l1=null;
         List<Brand> cl1=cdao1.getAllBrand();        
        
         if(cat==null && cloId==null)
         {
        	 cat="0";
        	 cloId="0";
        	 if(cat.trim().equals("0")&&cloId.trim().equals("0"))
             {
              	l1 =pdao.getAllProduct();
             }
         }
        
         
         else if(cloId!=null)
         {
        	 
        	 if(cloId.equals("0"))
        	 {
        		 l1 =pdao.getAllProduct();
        	 }
        	 
        	 else
        	 {
        		 int clotId=Integer.parseInt(cloId.trim());
                 l1=pdao.getProductByCloth(clotId);
        	 }
        	 	
         }
         
         else
         {
        	 if(cat.equals("0"))
        	 {
        		 l1 =pdao.getAllProduct();
        	 }
        	 
        	 else
        	 {
        	
             int categoryId=Integer.parseInt(cat.trim());
             l1=pdao.getProductByCategory(categoryId);	 
             
        	 }
              
         }
       
    %>

    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner" style="width:100%">
    <div class="carousel-item active">
      <img class="d-block w-100" src="images/home1.jpeg" alt="First slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="images/home2.jpg" alt="Second slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="images/home3.jpg" alt="Third slide">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>


<div class="text-center"><%@ include file="components/message.jsp"%></div>
<div class="container-fluid">

  
    
     
     
 
       </div>
                            
   
   <!-- ****************************************** -->

   <!-- show products -->
   
   <%
       if(searchResult!=null)
       {
    	   List<Product> listOfProductFromSearch=new ProductDaoImp().getSearchedProduct(searchResult);
   %>
     
     <div class="col-md-10">
          <h1 class="container">Our <span>Products</span></h1>
             <div class="row mt-4">
                 <div class="col-md-12 admin">
                     <div class="card-columns" >
                     
                         <%
                             String stock="Out Of Stock!!!"; 
                             for(Product p:listOfProductFromSearch)
                             {
                         %>
                         <div class="card p-2"  >
                        
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:270px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
                         
                             <div class="card-body" >
                                <h5 class="text-muted">Brand: <%=new BrandDaoImp().getBrandNameById(p.getCategoryId()) %> (<%=new ClothDaoImp().getClothNameById(p.getClothId()) %>) for: <%=p.getProductFor() %></h5>
                                <a href="product.jsp?productId=<%=p.getProductId() %>" style="text-decoration: none;color:black;"> <h5 class="card-title" ><%=p.getProductTitle() %></h5></a>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center">
                                 <p style="font-size:25px"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:20px;color:red"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:20px;color:green"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:20px;">Stock :</span>
                                  <span class="ml-1" style="font-size:20px"><%if(p.getProductQuantity()<1){ %><span style="color:red;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                            
                         </div>
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
            
         </div>
         
     <%
         } 
   
       else if(bId!=null && cId!=null && prodFor!=null && prodRange!=null)
       {
    	  
    	   int brId=Integer.parseInt(bId);
    	   int clId=Integer.parseInt(cId);
    	   int proRange=Integer.parseInt(prodRange);

    	   List<Product> listOfProductFromSearch=new ProductDaoImp().getSearchedProduct(prodFor, brId, clId, proRange);
     %>
           <div class="col-md-10">
         
         
             <div class="row mt-4">
                 <div class="col-md-12 admin">
                     <div class="card-columns">
                     
                         <%
                             String stock="Out Of Stock!!!"; 
                             for(Product p:listOfProductFromSearch)
                             {
                         %>
                         <div class="card p-2"  >
                        
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:270px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
                         
                             <div class="card-body" >
                                <h5 class="text-muted">Brand: <%=new BrandDaoImp().getBrandNameById(p.getCategoryId()) %> (<%=new ClothDaoImp().getClothNameById(p.getClothId()) %>) for: <%=p.getProductFor() %></h5>
                                <a href="product.jsp?productId=<%=p.getProductId() %>" style="text-decoration: none;color:black;"> <h5 class="card-title" ><%=p.getProductTitle() %></h5></a>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center">
                                 <p style="font-size:25px"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:20px;color:red"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:20px;color:green"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:20px;">Stock :</span>
                                  <span class="ml-1" style="font-size:20px"><%if(p.getProductQuantity()<1){ %><span style="color:red;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                            
                         </div>
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
            
         </div>
     <%
       }
   
       else
       {
     %> 
          <div class="col-md-12 ">
           <h1 class="container">Our <span>Products</span></h1>
         
             <div class="row mt-4">
                 <div class="col-md-12 admin">
                     <div class="card-columns hover" style="display:flex;">
                     
                         <%
                             String stock="Out Of Stock!!!"; 
                             for(Product p:l1)
                             {
                         %>
                        
                        <div class="card">
                              
                             <img src="productImages/<%=p.getProductPhoto() %>" style="max-height:270px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
                         
                             <div class="card-body">
                                 <h5 class="text-muted">Brand: <%=new BrandDaoImp().getBrandNameById(p.getCategoryId()) %> (<%=new ClothDaoImp().getClothNameById(p.getClothId()) %>) for: <%=p.getProductFor() %></h5>
                                 <h5 class="card-title"><a href="product.jsp?productId=<%=p.getProductId()%>" style="text-decoration: none;color:black;"> <%=p.getProductTitle() %></a></h5>
                                 <p class="card-text"><%=Helper.get10Words(p.getProductDescription()) %></p> 
                             </div>
                             <div class="card-footer text-center">
                                 <p style="font-size:25px"><span class="ml-2"><b>&#8377;<%=Helper.getProductSellingPrice(p.getProductPrice(), p.getProductDiscount()) %>/-</b></span>
                                 <span class="ml-2" style="font-size:20px;color:red"><s>&#8377;<%=p.getProductPrice()%></s></span>
                                  <span class="ml-2" style="font-size:20px;color:green"><%=p.getProductDiscount() %>&#37 off</span>
                                 </p>
                                  <span class="ml-2" style="font-size:20px;">Stock :</span>
                                  <span class="ml-1" style="font-size:20px"><%if(p.getProductQuantity()<1){ %><span style="color:red;"><b><%=stock%></b></span><%} else{ %><%=p.getProductQuantity()%><% } %></span>
                             </div>
                             
                         </div> 
                         
                         
                       
                         <%
                             
                             }
                         %>
                     </div>
                 </div>
             </div>
            
         </div>
     <%
       }
     %>
         
      <!-- **footer***** -->
      
       <!-- footer section start -->
        <footer class="bg pt-5 pb-4">
        <div class="container text-center text-md-left" style="font-size: 20px;">
            <div class="row text-center text-md-left">
                <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                    <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Coolpoint <i
                            class="fa fa-shopping-basket"></i></h5>
                    <p>Some things just
                        fill your heart
                        without trying !!
                        Coolpoint!!
                    </p>
                </div>
                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                    <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Contact Info</h5>
                    <p>
                        <a href="tel:8652617135" class="text-white" style="text-decoration: none;"><i
                                class="fa-solid fa-phone"></i>8652617135</a>
                    </p>
                    <p>
                        <a href="tel:8652617135" class="text-white" style="text-decoration: none;"><i
                                class="fa-solid fa-phone"></i>9768092069</a>
                    </p>
                    <p>
                        <a href="mailto:Coolpoint0041@gmail.com" class="text-white" style="text-decoration: none;"><i
                                class="fa-solid fa-envelope"></i>Coolpoint0041@gmail.com</a>

                    </p>


                    <p>
                        <a href="https://g.page/cool-point-maharashtra?share" class="links"><i
                                class="fa-solid fa-map-marker-alt"> </i>Shop No, 2, Dargah Rd, New Prakash Nagar,
                            Sonapur,
                            Bhandup West, Mumbai, Maharashtra 400078</a>
                    </p>


                </div>
               <!--   <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                    <h5 class="text-uppercase md-4 font-weight-bold text-warning">quick links</h5>
                    <p>
                        <a href="index.jsp" class="links"><i class="fa-solid fa-arrow-right"></i>Home</a>
                    </p>
                    <p>
                        <a href="product.jsp" class="links"><i class="fa-solid fa-arrow-right"></i>Product</a>
                    </p>
                    <p>
                        <a href="" class="links"><i class="fa-solid fa-arrow-right"></i>About us</a>
                    </p>
                    <p>
                        <a href="#Contact us" class="links"><i class="fa-solid fa-arrow-right"></i>Contact us</a>
                    </p>


                </div>-->
                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                    <h5 class="text-uppercase md-4 font-weight-bold text-warning">Payment Option Only Cash</h5>
                    <img src="images/cash.png" style="height:8rem; width:10rem;">
                </div>
            </div>
            <div class="md-4">
                <div class="row align-items-center">
                    <div class="col-md-7 col-lg-8">
                        <p>Copyright @2023 All rights reserved by:
                            <a href="#Coolpoint" style="text-decoration: none;">
                                <strong class="text-warning">The Providers</strong></a>
                        </p>
                    </div>
                    <div class="col-md-5 col-lg-4">
                        <div class="text-center text-md-right">
                            <ul class="list-ustyled list-inline">
                                <li class="list-inline-item">
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                            class="fa-brands fa-twitter"></i></a>
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                            class="fa-brands fa-whatsapp"></i></a>
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                            class="fa-brands fa-instagram"></i></a>
                                    <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                            class="fa-brands fa-facebook"></i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- footer section end -->
 
   
         

         
    

</body>
</html>