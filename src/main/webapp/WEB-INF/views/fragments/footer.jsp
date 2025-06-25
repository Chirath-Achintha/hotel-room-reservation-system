    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .footer {
            background: linear-gradient(90deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 2rem 0;
            border-radius: 24px 24px 0 0;
            box-shadow: 0 -2px 16px rgba(44,62,80,0.08);
            animation: footerFadeIn 1.2s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes footerFadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .footer .text-muted {
            color: #fbc2eb !important;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
    </style>
    <footer class="footer mt-auto py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">© 2024 Room Reservation System. All rights reserved.</span>
        </div>
    </footer>
</body>
</html>