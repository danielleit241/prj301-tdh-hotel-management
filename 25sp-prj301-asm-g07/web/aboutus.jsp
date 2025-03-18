<!DOCTYPE html>
<html lang="en">


    <head>
        <meta charset="UTF-8">
        <link rel="icon" href="images/thd-icon.png">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About Us - THD 5-Star Hotel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/ionicons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="js/script.js"></script>
    </head>
    <body class="about-us-styles">
        <%@include file="/navbar.jsp"%>
        <div class="container-about">
            <header>
                <h1 class="header-aboutus-h1">Welcome to THD 5-Star Hotel</h1>
                <p class="header-aboutus-p">Experience luxury, comfort, and elegance like never before.</p>
            </header>

            <section class="hotel-info">
                <div class="content-about">
                    <div class="image-container">
                        <img src="images/thd-5start.jpg" alt="Hotel Image" class="hotel-image">
                    </div>
                    <div class="text-content">
                        <p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.</p>
                        <p>Our hotel features stylish rooms, gourmet dining options, and world-class amenities. We are proud to offer personalized services, ensuring that each guest receives the highest level of comfort and satisfaction during their stay.</p>
                    </div>
                </div>
            </section>

            <section class="advantages">
                <h2>Why Choose Us?</h2>
                <div class="advantage-cards">
                    <div class="card-about">
                        <img src="images/pool.jpg" alt="Swimming Pool">
                        <h3>Luxurious Swimming Pool</h3>
                        <p>Relax by our sparkling pool after a busy day of sightseeing or meetings.</p>
                    </div>
                    <div class="card-about">
                        <img src="images/gym.jpg" alt="Gym">
                        <h3>Fully Equipped Gym</h3>
                        <p>Stay fit and healthy with our state-of-the-art fitness center.</p>
                    </div>
                    <div class="card-about">
                        <img src="images/5-start.jpg" alt="5 Star Standards">
                        <h3>5-Star Standards</h3>
                        <p>Experience the highest level of comfort and service with our 5-star accommodations.</p>
                    </div>
                </div>
            </section>

            <section class="achievements">
                <h2>Our Achievements</h2>
                <p>Over the years, THD Hotel has been recognized with several prestigious awards for excellence in service, customer satisfaction, and outstanding quality. Here are some of our top achievements:</p>
                <ul>
                    <li>Ranked among the Top 5-Star Hotels in Vietnam (2019-2023)</li>
                    <li>Winner of the "Best Luxury Hotel" Award, Vietnam Tourism Awards 2022</li>
                    <li>Recognized for exceptional customer service by global travel agencies</li>
                </ul>
            </section>

            <section class="contact-btn-about">
                <a href="contact.jsp" class="btn-about">Contact Us</a>
            </section>
        </div>
        <%@include file="footer.jsp" %>

    </body>
</html>
