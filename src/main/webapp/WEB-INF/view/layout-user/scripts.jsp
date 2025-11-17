<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Active menu highlighting script -->
<script>
    // Get current path
    const currentPath = window.location.pathname;

    // Remove active class from all nav links
    document.querySelectorAll('.nav-link').forEach((link) => {
        link.classList.remove('active');
    });

    // Add active class to current page link
    document.querySelectorAll('.nav-link').forEach((link) => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
</script>
