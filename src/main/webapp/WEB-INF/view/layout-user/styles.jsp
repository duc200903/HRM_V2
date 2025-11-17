<style>
    body {
        font-family: 'Inter', sans-serif;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    .navbar-brand {
        font-size: 1.5rem;
    }

    .nav-link {
        border-radius: 0.5rem;
        margin: 0 0.25rem;
        transition: all 0.3s ease;
    }

    .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .nav-link.active {
        background-color: rgba(255, 255, 255, 0.2);
        font-weight: 600;
    }

    .border-left-primary {
        border-left: 0.25rem solid #007bff !important;
    }
    .border-left-success {
        border-left: 0.25rem solid #28a745 !important;
    }
    .border-left-info {
        border-left: 0.25rem solid #17a2b8 !important;
    }
    .border-left-warning {
        border-left: 0.25rem solid #ffc107 !important;
    }

    .card {
        border: none;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        transition: all 0.3s ease;
    }

    .card:hover {
        transform: translateY(-3px);
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    }

    .card-header.bg-primary {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%) !important;
    }

    .list-group-item {
        border: none;
        border-radius: 0.5rem !important;
        margin-bottom: 0.5rem;
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        border-radius: 0.5rem;
    }

    .dropdown-item {
        border-radius: 0.375rem;
        margin: 0.125rem 0.5rem;
    }

    .dropdown-item:hover {
        background-color: #f8f9fa;
    }

    .btn {
        border-radius: 0.5rem;
        font-weight: 500;
    }

    .badge {
        font-weight: 500;
        padding: 0.5em 0.75em;
    }

    footer {
        margin-top: auto;
    }

    .text-gray-300 {
        color: #d1d5db !important;
    }

    .text-gray-800 {
        color: #1f2937 !important;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .h4 {
            font-size: 1.1rem;
        }
        .card-body {
            padding: 1rem;
        }
    }
</style>
