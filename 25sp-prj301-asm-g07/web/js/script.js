document.addEventListener('DOMContentLoaded', function () {
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
    }, {threshold: 0});

    sections.forEach(section => {
        observer.observe(section);
    });
});