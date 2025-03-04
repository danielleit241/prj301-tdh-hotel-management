<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <title>THD Hotel</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">
        <link rel="icon" href="images/fevicon.png" type="image/gif" />
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <!--font family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Monsieur+La+Doulaise&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Condiment&family=Monsieur+La+Doulaise&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">

        <!--footer-->
        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/ionicons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">








        <script>
            var video = document.getElementById('myVideo');
            video.addEventListener('play', function () {
                video.removeAttribute('controls');
            });
        </script>

    </head>
    <body class="main-layout">
        <%@include file="/navbar.jsp"%>
        <section class="banner_main">
            <div id="myCarousel" class="carousel slide banner" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div style="position: relative; height: 900px;"> 
                            <video autoplay muted loop>
                                <source src="images/intro.mp4" type="video/mp4">
                            </video>
                            <img class="" src="images/home3.svg" alt="Date" style="width: 65% ;position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1;"> 
                        </div>

                    </div>
                </div

        </section>
        <div id="about" class="about">
            <div class="container-fluid">
                <div class="row d_flex">
                    <div class="col-md-7" style="padding: 0px;">
                        <div class="about_img">
                            <figure><img src="images/about.png" alt="#" style="width: 90%"/></figure>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="titlepage">
                            <h2 style="font-family: 'Open Sans', sans-serif; font-weight: 600; text-align: left">About Us</h2>
                            <p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum. </p>
                            <a class="read_more" href="Javascript:void(0)" style="font-family: 'Open Sans', sans-serif; font-weight: 600; text-decoration: none; color: #CB1A3C"> Read More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>