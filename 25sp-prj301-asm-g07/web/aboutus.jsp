<!DOCTYPE html>
<html lang="en">
  

<head>
    
    <meta charset="UTF-8">
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
    <style>
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


body {
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
    background-color: #f4f4f4;
    color: #333;
}

.container {
    width: 90%;
    margin: 0 auto;
}

header {
    text-align: center;
    margin-top: 30px;
    
}

header h1 {

    font-size: 3em;
    color: #0044cc;
    margin-bottom: 10px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
    background-image: linear-gradient(to right, #007bff, #663399); 
    -webkit-background-clip: text;
     -webkit-text-fill-color: transparent;
    opacity: 0; 
    animation: fadeInWelcome 2s ease-out forwards;
    
}
@keyframes fadeInWelcome {
    0% {
        opacity: 0;
        transform: translateY(-20px); 
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

header p {
    font-size: 1.2em;
    color: black;
    margin-bottom: 40px;
}

.hotel-info {
    background-color: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 50px;
}

.hotel-info h2 {
    font-weight: bold;
    color: #333;
    font-size: 2em;
    margin-bottom: 20px;
}

.content {
    display: flex;
    justify-content: space-between;
}

.image-container {
    width: 45%;
}

.hotel-image {
    width: 100%;
    border-radius: 10px;
    transition: transform 0.3s ease;
}

.hotel-image:hover {
    transform: scale(1.05);
}

.text-content {
    width: 50%;
}

.text-content p {
    font-size: 1.1em;
    color: #666;
    margin-bottom: 20px;
}

.advantages {
    background-color: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 50px;
}

.advantages h2 {
    font-weight: bold;
    color: #333;
    font-size: 2em;
    margin-bottom: 20px;
}

.advantage-cards {
    display: flex;
    justify-content: space-between;
}

.card {
    width: 30%;
    background-color: #f9f9f9;
    padding: 20px;
    text-align: center;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.card:hover {
    transform: translateY(-10px);
}

.card img {
    width: 100%;
    border-radius: 10px;
    margin-bottom: 20px;
      width: 100%;
    height: auto; 
    display: block; 
}

.card h3 {
    color: #333;
    font-size: 1.5em;
    margin-bottom: 10px;
}

.card p {
    color: #666;
    font-size: 1.1em;
}

.achievements {
    background-color: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 50px;
}

.achievements h2 {
    font-weight: bold;
    color: #333;
    font-size: 2em;
    margin-bottom: 20px;
}

.achievements ul {
    list-style-type: disc;
    margin-left: 20px;
}

.achievements ul li {
    font-size: 1.1em;
    color: #666;
    margin: 10px 0;
   
    
}


.contact-btn {
    text-align: center;
    margin-top: 50px;
}

.contact-btn .btn {
    display: inline-block;
    background-color: #0044cc;
    color: white;
    padding: 15px 30px;
    font-size: 1.2em;
    text-decoration: none;
    border-radius: 5px;
    margin-top: -4%;
}
.contact-btn {
  text-align: center;
}

.contact-btn .btn {
  display: inline-block;
    padding: 15px 30px;
    font-size: 1.2em;
    text-decoration: none;
    border-radius: 8px;
    background-color: black; 
    color: white;
    font-weight: bold;
}

.contact-btn .btn:hover {
  background-color: #0056b3;
}
.advantages .advantage-cards {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
}

.advantages .card {
  width: 30%;
  margin-bottom: 2em;
  text-align: center;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.advantages .card img {
  width: 100%;
  height: auto;
}

.advantages .card:hover {
  transform: translateY(-5px);
}
.advantages, .achievements {
    opacity: 0;
    transform: translateY(20px);
    transition: opacity 0.5s ease, transform 0.5s ease;
}

.advantages.animated, .achievements.animated {
    opacity: 1;
    transform: translateY(0);
}
    </style>
    <script>
   document.addEventListener('DOMContentLoaded', function() {
    const sections = document.querySelectorAll('.advantages, .achievements');

    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            console.log(entry.target.id, entry.isIntersecting); 
            if (entry.isIntersecting) {
                entry.target.classList.add('animated');
            } else {
                entry.target.classList.remove('animated');
            }
        });
    }, { threshold: 0 });

    sections.forEach(section => {
        observer.observe(section);
    });
});
    </script>
</head>
<body>
    <%@include file="/navbar.jsp"%>
    <div class="container">
        <header>
            <h1>Welcome to THD 5-Star Hotel</h1>
            <p>Experience luxury, comfort, and elegance like never before.</p>
        </header>

        <section class="hotel-info">
            <h2>About THD Hotel</h2>
            <div class="content">
                <div class="image-container">
                    <img src="images/about1.jpg" alt="Hotel Image" class="hotel-image">
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
                <div class="card">
                    <img src="images/blog1.jpg" alt="Swimming Pool">
                    <h3>Luxurious Swimming Pool</h3>
                    <p>Relax by our sparkling pool after a busy day of sightseeing or meetings.</p>
                </div>
                <div class="card">
                    <img src="images/gym.jpg" alt="Gym">
                    <h3>Fully Equipped Gym</h3>
                    <p>Stay fit and healthy with our state-of-the-art fitness center.</p>
                </div>
                <div class="card">
                    <img src="images/blog2.jpg" alt="5 Star Standards">
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

        <section class="contact-btn">
            <a href="contact.jsp" class="btn">Contact Us</a>
        </section>
    </div>
    <%@include file="footer.jsp" %>
   
</body>
</html>
