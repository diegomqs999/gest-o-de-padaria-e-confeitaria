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
    <title>Controle de Estoque - Pão Di Mel</title>
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

        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .dashboard-card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            border: 2px solid #8B6F47;
            text-align: center;
        }

        .dashboard-card h3 {
            color: #8B6F47;
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .dashboard-card .number {
            color: #4A3319;
            font-size: 2.5em;
            font-weight: bold;
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

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #8B6F47;
        }

        .alert {
            background: #FFF3CD;
            border: 2px solid #FFE69C;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            color: #856404;
        }

        .alert-success {
            background: #D4EDDA;
            border-color: #C3E6CB;
            color: #155724;
        }

        .alert-danger {
            background: #F8D7DA;
            border-color: #F5C6CB;
            color: #721C24;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Controle de Estoque</h1>
            <a href="index.jsp" class="btn-voltar">← Voltar ao Menu</a>
        </div>

        <div class="content">
            <%
                List<Map<String, Object>> produtos = (List<Map<String, Object>>) session.getAttribute("produtos");
                
                if (produtos == null) {
                    produtos = new ArrayList<Map<String, Object>>();
                    session.setAttribute("produtos", produtos);
                }
                
                // Processar atualização de estoque
                String action = request.getParameter("action");
                String mensagem = null;
                String tipoMensagem = null;
                
                if ("atualizar".equals(action)) {
                    int produtoId = Integer.parseInt(request.getParameter("produtoId"));
                    String operacao = request.getParameter("operacao");
                    int quantidade = Integer.parseInt(request.getParameter("quantidade"));
                    
                    Map<String, Object> produtoSelecionado = null;
                    for (Map<String, Object> p : produtos) {
                        if ((Integer)p.get("id") == produtoId) {
                            produtoSelecionado = p;
                            break;
                        }
                    }
                    
                    if (produtoSelecionado != null) {
                        int estoqueAtual = (Integer) produtoSelecionado.get("estoque");
                        
                        if ("entrada".equals(operacao)) {
                            produtoSelecionado.put("estoque", estoqueAtual + quantidade);
                            mensagem = "Entrada de " + quantidade + " unidades registrada com sucesso!";
                            tipoMensagem = "success";
                        } else if ("saida".equals(operacao)) {
                            if (estoqueAtual >= quantidade) {
                                produtoSelecionado.put("estoque", estoqueAtual - quantidade);
                                mensagem = "Saída de " + quantidade + " unidades registrada com sucesso!";
                                tipoMensagem = "success";
                            } else {
                                mensagem = "ERRO: Quantidade insuficiente em estoque! Estoque atual: " + estoqueAtual + " unidades.";
                                tipoMensagem = "danger";
                            }
                        }
                        
                        session.setAttribute("produtos", produtos);
                    }
                }
                
                // Calcular dashboard
                int totalProdutos = produtos.size();
                int estoqueNormal = 0, estoqueBaixo = 0, estoqueCritico = 0;
                
                for (Map<String, Object> produto : produtos) {
                    int estoque = (Integer) produto.get("estoque");
                    int estoqueMin = (Integer) produto.get("estoqueMin");
                    
                    if (estoque <= 0) {
                        estoqueCritico++;
                    } else if (estoque <= estoqueMin) {
                        estoqueBaixo++;
                    } else {
                        estoqueNormal++;
                    }
                }
            %>

            <% if (mensagem != null) { %>
                <div class="alert alert-<%= tipoMensagem %>">
                    <%= mensagem %>
                </div>
            <% } %>

            <div class="dashboard">
                <div class="dashboard-card">
                    <h3>Total de Produtos</h3>
                    <div class="number"><%= totalProdutos %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Estoque Normal</h3>
                    <div class="number"><%= estoqueNormal %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Estoque Baixo</h3>
                    <div class="number"><%= estoqueBaixo %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Estoque Crítico</h3>
                    <div class="number"><%= estoqueCritico %></div>
                </div>
            </div>

            <h2 class="section-title">Atualizar Estoque</h2>
            
            <div class="form-container">
                <form method="post" action="estoque.jsp">
                    <input type="hidden" name="action" value="atualizar">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Produto *</label>
                            <select name="produtoId" required>
                                <option value="">Selecione um produto...</option>
                                <%
                                    for (Map<String, Object> p : produtos) {
                                %>
                                    <option value="<%= p.get("id") %>">
                                        <%= p.get("nome") %> (Estoque: <%= p.get("estoque") %> un)
                                    </option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Operação *</label>
                            <select name="operacao" required>
                                <option value="entrada">Entrada (Adicionar ao estoque)</option>
                                <option value="saida">Saída (Remover do estoque)</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Quantidade *</label>
                            <input type="number" name="quantidade" min="1" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Motivo</label>
                        <textarea name="motivo" placeholder="Ex: Compra, Venda, Perda, Produção..."></textarea>
                    </div>
                    <button type="submit" class="btn">Atualizar Estoque</button>
                </form>
            </div>

            <h2 class="section-title">Status do Estoque</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Produto</th>
                        <th>Categoria</th>
                        <th>Quantidade Atual</th>
                        <th>Estoque Mínimo</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (produtos.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="6" class="empty-state">Nenhum produto no estoque</td>
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
                            <td><%= produto.get("estoque") %> un</td>
                            <td><%= produto.get("estoqueMin") %> un</td>
                            <td><span class="status-badge <%= statusClass %>"><%= statusText %></span></td>
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