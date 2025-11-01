<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
    <title>Produtos - Pão Di Mel</title>
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
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            background: #4A3319;
            color: #F5E6D3;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        .header h1 {
            font-size: 2.5em;
        }

        .btn-voltar {
            background: #F5E6D3;
            color: #4A3319;
            border: none;
            padding: 12px 25px;
            font-size: 1em;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-voltar:hover {
            background: #8B6F47;
            color: #F5E6D3;
        }

        .content {
            background: #F5E6D3;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        .section-title {
            color: #4A3319;
            font-size: 2em;
            margin-bottom: 20px;
            border-bottom: 3px solid #8B6F47;
            padding-bottom: 10px;
        }

        .form-container {
            background: white;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 2px solid #8B6F47;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            color: #4A3319;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #D4A574;
            border-radius: 5px;
            font-size: 1em;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
        }

        .btn {
            background: #4A3319;
            color: #F5E6D3;
            border: none;
            padding: 12px 25px;
            font-size: 1em;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background: #8B6F47;
            transform: translateY(-2px);
        }

        .btn-edit {
            background: #4A90E2;
            padding: 8px 15px;
            font-size: 0.9em;
        }

        .btn-edit:hover {
            background: #357ABD;
        }

        .btn-delete {
            background: #8B1A1A;
            padding: 8px 15px;
            font-size: 0.9em;
        }

        .btn-delete:hover {
            background: #A52A2A;
        }

        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        th {
            background: #4A3319;
            color: #F5E6D3;
            padding: 15px;
            text-align: left;
            font-weight: bold;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #D4A574;
        }

        tr:hover {
            background: #FFF8F0;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
            font-weight: bold;
        }

        .status-normal {
            background: #4CAF50;
            color: white;
        }

        .status-baixo {
            background: #FF9800;
            color: white;
        }

        .status-critico {
            background: #F44336;
            color: white;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #8B6F47;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Gestão de Produtos</h1>
            <a href="index.jsp" class="btn-voltar">← Voltar ao Menu</a>
        </div>

        <div class="content">
            <h2 class="section-title">Cadastrar Novo Produto</h2>
            
            <div class="form-container">
                <form method="post" action="produtos.jsp">
                    <input type="hidden" name="action" value="adicionar">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Nome do Produto *</label>
                            <input type="text" name="nome" required>
                        </div>
                        <div class="form-group">
                            <label>Categoria *</label>
                            <select name="categoria" required>
                                <option value="">Selecione...</option>
                                <option value="Cupcakes">Cupcakes</option>
                                <option value="Pães de Mel">Pães de Mel</option>
                                <option value="Donuts">Donuts</option>
                                <option value="Bolos">Bolos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Preço (R$) *</label>
                            <input type="number" name="preco" step="0.01" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Quantidade em Estoque *</label>
                            <input type="number" name="estoque" required>
                        </div>
                        <div class="form-group">
                            <label>Estoque Mínimo *</label>
                            <input type="number" name="estoqueMin" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Descrição</label>
                        <textarea name="descricao"></textarea>
                    </div>
                    <button type="submit" class="btn">Cadastrar Produto</button>
                </form>
            </div>

            <h2 class="section-title">Lista de Produtos</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Categoria</th>
                        <th>Preço</th>
                        <th>Estoque</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Map<String, Object>> produtos = (List<Map<String, Object>>) session.getAttribute("produtos");
                        
                        if (produtos == null) {
                            produtos = new ArrayList<Map<String, Object>>();
                            
                            // Dados de exemplo
                            Map<String, Object> p1 = new HashMap<String, Object>();
                            p1.put("id", 1);
                            p1.put("nome", "Cupcake Tradicional");
                            p1.put("categoria", "Cupcakes");
                            p1.put("preco", 8.00);
                            p1.put("estoque", 25);
                            p1.put("estoqueMin", 10);
                            p1.put("descricao", "Cupcake clássico com cobertura de buttercream");
                            produtos.add(p1);
                            
                            Map<String, Object> p2 = new HashMap<String, Object>();
                            p2.put("id", 2);
                            p2.put("nome", "Pão de Mel Tradicional");
                            p2.put("categoria", "Pães de Mel");
                            p2.put("preco", 5.00);
                            p2.put("estoque", 48);
                            p2.put("estoqueMin", 20);
                            p2.put("descricao", "Pão de mel artesanal coberto com chocolate");
                            produtos.add(p2);
                            
                            Map<String, Object> p3 = new HashMap<String, Object>();
                            p3.put("id", 3);
                            p3.put("nome", "Rosquinha Donuts");
                            p3.put("categoria", "Donuts");
                            p3.put("preco", 6.00);
                            p3.put("estoque", 5);
                            p3.put("estoqueMin", 15);
                            p3.put("descricao", "Donuts fresquinhos com cobertura variada");
                            produtos.add(p3);
                            
                            session.setAttribute("produtos", produtos);
                        }
                        
                        // Processar adição de produto
                        String action = request.getParameter("action");
                        if ("adicionar".equals(action)) {
                            int novoId = produtos.size() + 1;
                            Map<String, Object> novoProduto = new HashMap<String, Object>();
                            novoProduto.put("id", novoId);
                            novoProduto.put("nome", request.getParameter("nome"));
                            novoProduto.put("categoria", request.getParameter("categoria"));
                            novoProduto.put("preco", Double.parseDouble(request.getParameter("preco")));
                            novoProduto.put("estoque", Integer.parseInt(request.getParameter("estoque")));
                            novoProduto.put("estoqueMin", Integer.parseInt(request.getParameter("estoqueMin")));
                            novoProduto.put("descricao", request.getParameter("descricao"));
                            produtos.add(novoProduto);
                            session.setAttribute("produtos", produtos);
                            response.sendRedirect("produtos.jsp");
                        }
                        
                        // Processar exclusão - SEM LAMBDA
                        if ("excluir".equals(action)) {
                            int idExcluir = Integer.parseInt(request.getParameter("id"));
                            Iterator<Map<String, Object>> iterator = produtos.iterator();
                            while (iterator.hasNext()) {
                                Map<String, Object> p = iterator.next();
                                if ((Integer)p.get("id") == idExcluir) {
                                    iterator.remove();
                                    break;
                                }
                            }
                            session.setAttribute("produtos", produtos);
                            response.sendRedirect("produtos.jsp");
                        }
                        
                        if (produtos.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="7" class="empty-state">Nenhum produto cadastrado</td>
                        </tr>
                    <%
                        } else {
                            for (Map<String, Object> produto : produtos) {
                                int estoque = (Integer) produto.get("estoque");
                                int estoqueMin = (Integer) produto.get("estoqueMin");
                                String statusClass = "status-normal";
                                String statusText = "Normal";
                                
                                if (estoque <= 0) {
                                    statusClass = "status-critico";
                                    statusText = "Crítico";
                                } else if (estoque <= estoqueMin) {
                                    statusClass = "status-baixo";
                                    statusText = "Baixo";
                                }
                    %>
                        <tr>
                            <td><%= produto.get("id") %></td>
                            <td><%= produto.get("nome") %></td>
                            <td><%= produto.get("categoria") %></td>
                            <td>R$ <%= String.format("%.2f", produto.get("preco")) %></td>
                            <td><%= produto.get("estoque") %> un</td>
                            <td><span class="status-badge <%= statusClass %>"><%= statusText %></span></td>
                            <td class="actions">
                                <a href="produtos.jsp?action=excluir&id=<%= produto.get("id") %>" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Tem certeza que deseja excluir este produto?')">Excluir</a>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>