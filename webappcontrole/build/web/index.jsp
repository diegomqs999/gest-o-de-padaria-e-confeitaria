<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pão Di Mel - Sistema de Gestão</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #8B6F47 0%, #D4A574 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Menu Hambúrguer */
        .menu-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background: #4A3319;
            border: none;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
        }

        .menu-toggle:hover {
            background: #8B6F47;
            transform: scale(1.05);
        }

        .menu-toggle span {
            display: block;
            width: 30px;
            height: 3px;
            background: #F5E6D3;
            margin: 6px 0;
            border-radius: 3px;
            transition: all 0.3s ease;
        }

        .menu-toggle.active span:nth-child(1) {
            transform: rotate(45deg) translate(8px, 8px);
        }

        .menu-toggle.active span:nth-child(2) {
            opacity: 0;
        }

        .menu-toggle.active span:nth-child(3) {
            transform: rotate(-45deg) translate(8px, -8px);
        }

        /* Sidebar Menu */
        .sidebar {
            position: fixed;
            left: -300px;
            top: 0;
            width: 300px;
            height: 100vh;
            background: #4A3319;
            box-shadow: 4px 0 10px rgba(0,0,0,0.3);
            z-index: 999;
            transition: left 0.3s ease;
            overflow-y: auto;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar-header {
            padding: 30px 20px;
            background: #3A2310;
            text-align: center;
            border-bottom: 2px solid #8B6F47;
        }

        .sidebar-header h1 {
            color: #F5E6D3;
            font-size: 1.8em;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            color: #D4A574;
            font-size: 0.9em;
        }

        .menu-items {
            padding: 20px 0;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #F5E6D3;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .menu-item:hover {
            background: #5A4329;
            border-left-color: #D4A574;
            padding-left: 30px;
        }

        .menu-item .icon {
            font-size: 1.5em;
            margin-right: 15px;
            width: 30px;
            text-align: center;
        }

        .menu-item .text {
            font-size: 1.1em;
        }

        /* Overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 998;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* Conteúdo Principal */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

        .header {
            background: #4A3319;
            color: #F5E6D3;
            padding: 30px;
            border-radius: 15px;
            margin-top: 80px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        .header h1 {
            font-size: 3em;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 1.2em;
            color: #D4A574;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: #F5E6D3;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            border: 3px solid transparent;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.4);
            border-color: #8B6F47;
        }

        .card-icon {
            font-size: 3em;
            margin-bottom: 15px;
            text-align: center;
        }

        .card h2 {
            color: #4A3319;
            font-size: 1.5em;
            margin-bottom: 10px;
            text-align: center;
        }

        .card p {
            color: #8B6F47;
            text-align: center;
            line-height: 1.6;
        }

        .info-section {
            background: #F5E6D3;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
            margin-bottom: 30px;
        }

        .info-section h2 {
            color: #4A3319;
            font-size: 2em;
            margin-bottom: 20px;
            border-bottom: 3px solid #8B6F47;
            padding-bottom: 10px;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .feature-item {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #8B6F47;
        }

        .feature-item h3 {
            color: #4A3319;
            margin-bottom: 10px;
        }

        .feature-item p {
            color: #8B6F47;
            line-height: 1.6;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #F5E6D3;
            margin-top: 150px;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .card-icon {
                font-size: 2.5em;
            }
        }
    </style>
</head>
<body>
    <!-- Botão Menu -->
    <button class="menu-toggle" id="menuToggle">
        <span></span>
        <span></span>
        <span></span>
    </button>

    <!-- Overlay -->
    <div class="overlay" id="overlay"></div>

    <!-- Sidebar Menu -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h1> Pão Di Mel</h1>
            <p>Sistema de Gestão</p>
        </div>
        <div class="menu-items">
            <a href="index.jsp" class="menu-item">
               
                <span class="text">Início</span>
            </a>
            <a href="produtos.jsp" class="menu-item">

                <span class="text">Produtos</span>
            </a>
            <a href="estoque.jsp" class="menu-item">

                <span class="text">Estoque</span>
            </a>
            <a href="pedidos.jsp" class="menu-item">
                
                <span class="text">Pedidos</span>
            </a>
            <a href="fornecedores.jsp" class="menu-item">
                
                <span class="text">Fornecedores</span>
            </a>
        </div>
    </nav>

    <!-- Conteúdo Principal -->
    <div class="container">
        <div class="header">
            <h1>Pão Di Mel</h1>
            <p>Sistema Completo de Gestão da padaria e confeitaria Pão Di Mel</p>
        </div>

        <div class="dashboard-grid">
            <a href="produtos.jsp" class="card">
                
                <h2>Produtos</h2>
                <p>Cadastre e gerencie todos os seus produtos, categorias e preços</p>
            </a>

            <a href="estoque.jsp" class="card">
               
                <h2>Controle de Estoque</h2>
                <p>Monitore entradas, saídas e níveis de estoque em tempo real</p>
            </a>

            <a href="pedidos.jsp" class="card">
                
                <h2>Pedidos</h2>
                <p>Gerencie todos os pedidos dos seus clientes de forma eficiente</p>
            </a>

            <a href="fornecedores.jsp" class="card">
                
                <h2>Fornecedores</h2>
                <p>Mantenha cadastro completo de fornecedores e contatos</p>
            </a>
        </div>

        

        <footer>
            <p>© 2025 Pão Di Mel - Sistema de Gestão | Todos os direitos reservados</p>
        </footer>
    </div>

    <script>
        // Menu Toggle
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('overlay');

        function toggleMenu() {
            menuToggle.classList.toggle('active');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
        }

        menuToggle.addEventListener('click', toggleMenu);
        overlay.addEventListener('click', toggleMenu);

        // Fechar menu ao clicar em um item (mobile)
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                if (window.innerWidth <= 768) {
                    toggleMenu();
                }
            });
        });

        // Fechar menu com tecla ESC
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && sidebar.classList.contains('active')) {
                toggleMenu();
            }
        });
    </script>
</body>
</html>