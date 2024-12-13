<%-- 
    Document   : newjsp
    Created on : Aug 5, 2023, 5:48:53 AM
    Author     : lakru
--%>

<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
javax.servlet.http.Cookie[] cookies = request.getCookies();
    String U_ID = null;

    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if ("U_ID".equals(cookie.getName())) {
                U_ID = URLDecoder.decode(cookie.getValue(), "UTF-8");
                break;
            }
        }
    }else{
        response.sendRedirect("logn.jsp");
    }

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Marketing Team DashBoard</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script type="module"src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="skcss.css" />
    </head>
    <body>
        <div class="container">
            
            <br><br>            
            <div class="row">
                <h2>Manage Suppliers</h2><hr class="pt-0 pb-0">                
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3 pt-1">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="offcanvas" data-bs-target="#Requests">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-magnifying-glass"></i></h1></div>
                            <h2>Pending Request</h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3 pt-1">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#sends">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-paper-plane"></i></h1></div>
                            <h2>Send Request</h2>                            
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3 pt-1">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="offcanvas" data-bs-target="#Transfers">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-plane-arrival"></i></h1></div>
                            <h2>Transfer History</h2>
                        </div>
                    </div>
                </div>
            </div>
            
            <br><br>            
            <div class="row">
                <h2>Manage Store</h2><hr class="pt-0 pb-0">                
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3">
                    <div class="card cardsFirstAW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#add">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-plus"></i></h1></div>
                            <h2>Add item to Store</h2>
                        </div>
                    </div>
                </div>
            </div>
            
            <br><br>            
            <div class="row">               
                <h2>Manage Marketing team</h2><hr class="pt-0 pb-0">
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3 pt-1">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="offcanvas" data-bs-target="#Requestm">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-magnifying-glass"></i></h1></div>
                            <h2>Pending Request</h2>
                        </div>
                    </div>
                </div>                
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3 pt-1">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#sendm">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-dolly"></i></h1></div>
                            <h2>Send item</h2>                            
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 text-center p-3 pt-1">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="offcanvas" data-bs-target="#Transferm">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-plane-departure"></i></h1></div>
                            <h2>Transfer History</h2>
                        </div>
                    </div>
                </div>
            </div>

            <br><br>

            <!--Table Start-->
            <div class="row">
                <!--Recently Added Products Table Start-->
                <div class="col-md-6">
                    <div class="text-center mt-2">
                        <h4>Recently Added products</h4>
                    </div>
                    <table class="table text-center">
                        <th scope="col">Added Date</th>
                        <th scope="col">Product Id</th>
                        <th scope="col">Product name</th>
                        <th scope="col">Product Image</th>
                        <th scope="col">Quantity(Pieces)</th>
                        <tr class="table-light">
                            <td>12.06.2023</td>
                            <td>P001</td>
                            <td>Blue Bird Shirt</td>
                            <td><img src="https://www.beverlystreet.lk/media/catalog/product/cache/1/small_image/320x/040ec09b1e35df139433887a97daa66f/5/5/5541.jpg"style="height: 30px; width: 30px" /></td>
                            <td>1000</td>
                        </tr>
                        <tr class="table-secondary">
                            <td>12.06.2023</td>
                            <td>P002</td>
                            <td>Blue Bird Jeans</td>
                            <td><img src="https://www.styledbysally.com.au/wp-content/uploads/2018/01/Classic-Blue-Men-Jeans-Pant-Cotton-Slim-Fit-Men-s-Denim-Pants-Stretch-Fashion-Mens-Clothes.jpg" style="height: 30px; width: 30px"/></td>
                            <td>800</td>
                        </tr>
                        <tr class="table-light">
                            <td>12.06.2023</td>
                            <td>P003</td>
                            <td>Yello Crispy T-Shirt</td>
                            <td><img src="https://5.imimg.com/data5/FW/GT/MY-23375112/men-s-yellow-color-t-shirt.jpg" style="height: 30px; width: 30px" /></td>
                            <td>650</td>
                        </tr>
                        <tr class="table-secondary">
                            <td>12.06.2023</td>
                            <td>P004</td>
                            <td>Black Skirts</td>
                            <td><img src="https://www.ubuy.com.lk/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNjFmSXpDUW9kMEwuX0FDX1VMMTIzMF8uanBn.jpg" style="height: 30px; width: 30px"/></td>
                            <td>500</td>
                        </tr>
                        <tr class="table-light">
                            <td>12.06.2023</td>
                            <td>P005</td>
                            <td>Red Salvar</td>
                            <td><img src="https://singlekart.com/wp-content/uploads/2019/11/04-1.jpg" style="height: 30px; width: 30px" /></td>
                            <td>250</td>
                        </tr>
                    </table>
                </div>
                <!--Recently Added Products Table end-->

                <!--Recently Supplied Products Table Start-->
                <div class="col-md-6">
                    <div class="text-center mt-2">
                        <h4>Recently Added products</h4>
                    </div>
                    <table class="table text-center">
                        <th scope="col">Added Date</th>
                        <th scope="col">Product Id</th>
                        <th scope="col">Product name</th>
                        <th scope="col">Product Image</th>
                        <th scope="col">Quantity(Pieces)</th>
                        <tr class="table-light">
                            <td>12.06.2023</td>
                            <td>P001</td>
                            <td>Blue Bird Shirt</td>
                            <td><img src="https://www.beverlystreet.lk/media/catalog/product/cache/1/small_image/320x/040ec09b1e35df139433887a97daa66f/5/5/5541.jpg"style="height: 30px; width: 30px" /></td>
                            <td>1000</td>
                        </tr>
                        <tr class="table-secondary">
                            <td>12.06.2023</td>
                            <td>P002</td>
                            <td>Blue Bird Jeans</td>
                            <td><img src="https://www.styledbysally.com.au/wp-content/uploads/2018/01/Classic-Blue-Men-Jeans-Pant-Cotton-Slim-Fit-Men-s-Denim-Pants-Stretch-Fashion-Mens-Clothes.jpg" style="height: 30px; width: 30px"/></td>
                            <td>800</td>
                        </tr>
                        <tr class="table-light">
                            <td>12.06.2023</td>
                            <td>P003</td>
                            <td>Yello Crispy T-Shirt</td>
                            <td><img src="https://5.imimg.com/data5/FW/GT/MY-23375112/men-s-yellow-color-t-shirt.jpg" style="height: 30px; width: 30px" /></td>
                            <td>650</td>
                        </tr>
                        <tr class="table-secondary">
                            <td>12.06.2023</td>
                            <td>P004</td>
                            <td>Black Skirts</td>
                            <td><img src="https://www.ubuy.com.lk/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNjFmSXpDUW9kMEwuX0FDX1VMMTIzMF8uanBn.jpg" style="height: 30px; width: 30px"/></td>
                            <td>500</td>
                        </tr>
                        <tr class="table-light">
                            <td>12.06.2023</td>
                            <td>P005</td>
                            <td>Red Salvar</td>
                            <td><img src="https://singlekart.com/wp-content/uploads/2019/11/04-1.jpg" style="height: 30px; width: 30px" /></td>
                            <td>250</td>
                        </tr>
                        <tr class="table-secondary"></tr>
                        <tr class="table-light"></tr>
                        <tr class="table-secondary"></tr>
                    </table>
                </div>
                <!--Recently Supplied Products Table Start-->
            </div>



            <!--model start-->    
            <!--Send req start-->
            <div class="modal fade" id="sends" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Send Request to Supplier</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form class="was-validated">
                                <div class="row">
                                    <label class="form-label">Select Product Name</label>
                                    <select class="form-select  mb-3" required a>            
                                        <option value="1">Name 1</option>
                                        <option value="2">Name 2</option>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="col-12">
                                        <label class="form-label">Unit price</label>
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" disabled>
                                            <span class="input-group-text">.00</span>
                                        </div>
                                    </div>
                                </div> 
                                <div class="row">
                                    <label class="form-label">Select Supplier</label>
                                    <select class="form-select  mb-3" required a>            
                                        <option value="1">Supplier 1</option>
                                        <option value="2">Supplier 2</option>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="mb-2">
                                        <label class="form-label">Quantity</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                            <button type="button" class="btn btn-primary">Request</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--Send req end-->   
            
            <!--Add items to store start-->
            <div class="modal fade" id="add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Send Request to Supplier</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form class="was-validated">
                                <div class="row">
                                    <label class="form-label">Choose Available Product</label>
                                    <select class="form-select  mb-3" required a>            
                                        <option value="1">Name 1</option>
                                        <option value="2">Name 2</option>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="col-12">
                                        <label class="form-label">Quantity</label>
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" disabled>
                                        </div>
                                    </div>
                                </div> 
                                <div class="row">
                                    <label class="form-label">Select Supplier</label>
                                    <select class="form-select  mb-3" required a>            
                                        <option value="1">Supplier 1</option>
                                        <option value="2">Supplier 2</option>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="mb-2">
                                        <label class="form-label">Available Quantity</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" disabled>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                            <button type="button" class="btn btn-primary">Add To Store</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--Add items to store end-->
            
            <!--Send item-->
            <div class="modal fade" id="sendm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Send Item to Marketing Team</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form class="was-validated">
                                <div class="row">
                                    <label class="form-label">Select Product Name</label>
                                    <select class="form-select  mb-3" required a>            
                                        <option value="1">Name 1</option>
                                        <option value="2">Name 2</option>
                                    </select>
                                </div>                                
                                <br><div class="row">
                                    <div class="col-12">
                                        <label class="form-label">Unit price</label>
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" disabled>
                                            <span class="input-group-text">.00</span>
                                        </div>
                                    </div>
                                </div>                                 
                                <div class="row">
                                    <label class="form-label">Select Marketing Team Member</label>
                                    <select class="form-select  mb-3" required a>            
                                        <option value="1">Store Keeper 1</option>
                                        <option value="2">Store Keeper 2</option>
                                    </select>
                                </div>                                
                                <br><div class="row">
                                    <div class="mb-2">
                                        <label class="form-label">Quantity</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="basic-url">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                            <button type="button" class="btn btn-primary">Send</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--Send Item--> 
            <!--model end-->

            <!--off canvas start-->   
            <!--Pending Request supplier start-->
            <div class="offcanvas offcanvas-start" data-bs-backdrop="static" tabindex="-1" id="Requests" style="width: 100%;">
                <div class="offcanvas-header">
                    <h3 class="offcanvas-title">Pending Request With Supplier </h3>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>
                <div class="offcanvas-body">
                    <div>
                        <div class="col tableBody">
                            <table class="table text-center">
                                <th scope="col">Added Date</th>
                                <th scope="col">Product Id</th>
                                <th scope="col">Product name</th>
                                <th scope="col">Product Image</th>
                                <th scope="col">Quantity(Pieces)</th>
                                <tr class="table-light">
                                    <td>12.06.2023</td>
                                    <td>P001</td>
                                    <td>Blue Bird Shirt</td>
                                    <td><img src="https://www.beverlystreet.lk/media/catalog/product/cache/1/small_image/320x/040ec09b1e35df139433887a97daa66f/5/5/5541.jpg"style="height: 30px; width: 30px" /></td>
                                    <td>1000</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--View Request supplier End-->
            
            <!--Pending Request Marketing team start-->
            <div class="offcanvas offcanvas-start" data-bs-backdrop="static" tabindex="-1" id="Requestm" style="width: 100%;">
                <div class="offcanvas-header">
                    <h3 class="offcanvas-title">Pending Request From Marketing team  </h3>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>
                <div class="offcanvas-body">
                    <div>
                        <div class="col tableBody">
                            <table class="table text-center">
                                <th scope="col">Added Date</th>
                                <th scope="col">Product Id</th>
                                <th scope="col">Product name</th>
                                <th scope="col">Product Image</th>
                                <th scope="col">Quantity(Pieces)</th>
                                <tr class="table-light">
                                    <td>12.06.2023</td>
                                    <td>P001</td>
                                    <td>Blue Bird Shirt</td>
                                    <td><img src="https://www.beverlystreet.lk/media/catalog/product/cache/1/small_image/320x/040ec09b1e35df139433887a97daa66f/5/5/5541.jpg"style="height: 30px; width: 30px" /></td>
                                    <td>1000</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--View Request Marketing team End-->

            <!--Transfer History supplier start-->
            <div class="offcanvas offcanvas-start" data-bs-backdrop="static" tabindex="-1" id="Transfers" style="width: 100%;">
                <div class="offcanvas-header">
                    <h3 class="offcanvas-title">Transfer History With Suppliers</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>
                <div class="offcanvas-body">
                    <div>
                        <div class="col tableBody">
                            <table class="table text-center">
                                <th scope="col">Added Date</th>
                                <th scope="col">Product Id</th>
                                <th scope="col">Product name</th>
                                <th scope="col">Product Image</th>
                                <th scope="col">Quantity(Pieces)</th>
                                <tr class="table-light">
                                    <td>12.06.2023</td>
                                    <td>P001</td>
                                    <td>Blue Bird Shirt</td>
                                    <td><img src="https://www.beverlystreet.lk/media/catalog/product/cache/1/small_image/320x/040ec09b1e35df139433887a97daa66f/5/5/5541.jpg"style="height: 30px; width: 30px" /></td>
                                    <td>1000</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--Transfer History supplier End-->
            
            <!--Transfer History Marketing team start-->
            <div class="offcanvas offcanvas-start" data-bs-backdrop="static" tabindex="-1" id="Transferm" style="width: 100%;">
                <div class="offcanvas-header">
                    <h3 class="offcanvas-title">Transfer History With Marketing Team</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>
                <div class="offcanvas-body">
                    <div>
                        <div class="col tableBody">
                            <table class="table text-center">
                                <th scope="col">Added Date</th>
                                <th scope="col">Product Id</th>
                                <th scope="col">Product name</th>
                                <th scope="col">Product Image</th>
                                <th scope="col">Quantity(Pieces)</th>
                                <tr class="table-light">
                                    <td>12.06.2023</td>
                                    <td>P001</td>
                                    <td>Blue Bird Shirt</td>
                                    <td><img src="https://www.beverlystreet.lk/media/catalog/product/cache/1/small_image/320x/040ec09b1e35df139433887a97daa66f/5/5/5541.jpg"style="height: 30px; width: 30px" /></td>
                                    <td>1000</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--Transfer History Marketing team End-->
            <!--off canvas end-->  

        </div>
    </body>
</html>