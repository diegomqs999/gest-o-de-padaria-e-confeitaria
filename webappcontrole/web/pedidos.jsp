<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
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
    <title>Pedidos - Pão Di Mel</title>
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

        .status-pendente {
            background: #FFC107;
            color: #4A3319;
        }

        .status-preparando {
            background: #2196F3;
            color: white;
        }

        .status-entregue {
            background: #4CAF50;
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
            <h1>Gestão de Pedidos</h1>
            <a href="index.jsp" class="btn-voltar">← Voltar ao Menu</a>
        </div>

        <div class="content">
            <%
                List<Map<String, Object>> produtos = (List<Map<String, Object>>) session.getAttribute("produtos");
                List<Map<String, Object>> pedidos = (List<Map<String, Object>>) session.getAttribute("pedidos");
                
                if (pedidos == null) {
                    pedidos = new ArrayList<Map<String, Object>>();
                    session.setAttribute("pedidos", pedidos);
                }
                
                // Processar adição de pedido
                String action = request.getParameter("action");
                if ("adicionar".equals(action) && produtos != null) {
                    int novoId = pedidos.size() + 1;
                    int produtoId = Integer.parseInt(request.getParameter("produtoId"));
                    int quantidade = Integer.parseInt(request.getParameter("quantidade"));
                    
                    Map<String, Object> produtoSelecionado = null;
                    for (Map<String, Object> p : produtos) {
                        if ((Integer)p.get("id") == produtoId) {
                            produtoSelecionado = p;
                            break;
                        }
                    }
                    
                    if (produtoSelecionado != null) {
                        double preco = (Double) produtoSelecionado.get("preco");
                        double valorTotal = preco * quantidade;
                        
                        Map<String, Object> novoPedido = new HashMap<String, Object>();
                        novoPedido.put("id", novoId);
                        novoPedido.put("cliente", request.getParameter("cliente"));
                        novoPedido.put("telefone", request.getParameter("telefone"));
                        novoPedido.put("produtoNome", produtoSelecionado.get("nome"));
                        novoPedido.put("quantidade", quantidade);
                        novoPedido.put("valorTotal", valorTotal);
                        novoPedido.put("dataEntrega", request.getParameter("dataEntrega"));
                        novoPedido.put("status", request.getParameter("status"));
                        novoPedido.put("observacoes", request.getParameter("observacoes"));
                        novoPedido.put("dataCriacao", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
                        pedidos.add(novoPedido);
                        
                        // Atualizar estoque
                        int estoqueAtual = (Integer) produtoSelecionado.get("estoque");
                        produtoSelecionado.put("estoque", estoqueAtual - quantidade);
                        
                        session.setAttribute("pedidos", pedidos);
                        session.setAttribute("produtos", produtos);
                        response.sendRedirect("pedidos.jsp");
                    }
                }
                
                // Processar exclusão - SEM LAMBDA
                if ("excluir".equals(action)) {
                    int idExcluir = Integer.parseInt(request.getParameter("id"));
                    Iterator<Map<String, Object>> iterator = pedidos.iterator();
                    while (iterator.hasNext()) {
                        Map<String, Object> p = iterator.next();
                        if ((Integer)p.get("id") == idExcluir) {
                            iterator.remove();
                            break;
                        }
                    }
                    session.setAttribute("pedidos", pedidos);
                    response.sendRedirect("pedidos.jsp");
                }
                
                // Calcular dashboard
                int pendentes = 0, preparando = 0, entregues = 0;
                double valorTotal = 0;
                String dataHoje = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
                
                for (Map<String, Object> pedido : pedidos) {
                    String status = (String) pedido.get("status");
                    if ("Pendente".equals(status)) pendentes++;
                    if ("Preparando".equals(status)) preparando++;
                    if ("Entregue".equals(status) && dataHoje.equals(pedido.get("dataCriacao"))) entregues++;
                    valorTotal += (Double) pedido.get("valorTotal");
                }
            %>

            <div class="dashboard">
                <div class="dashboard-card">
                    <h3>Pedidos Pendentes</h3>
                    <div class="number"><%= pendentes %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Em Preparação</h3>
                    <div class="number"><%= preparando %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Entregues Hoje</h3>
                    <div class="number"><%= entregues %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Valor Total</h3>
                    <div class="number">R$ <%= String.format("%.2f", valorTotal) %></div>
                </div>
            </div>

            <h2 class="section-title">Novo Pedido</h2>
            
            <div class="form-container">
                <form method="post" action="pedidos.jsp">
                    <input type="hidden" name="action" value="adicionar">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Nome do Cliente *</label>
                            <input type="text" name="cliente" required>
                        </div>
                        <div class="form-group">
                            <label>Telefone *</label>
                            <input type="tel" name="telefone" required>
                        </div>
                        <div class="form-group">
                            <label>Produto *</label>
                            <select name="produtoId" required>
                                <option value="">Selecione um produto...</option>
                                <%
                                    if (produtos != null) {
                                        for (Map<String, Object> p : produtos) {
                                %>
                                    <option value="<%= p.get("id") %>"><%= p.get("nome") %> - R$ <%= String.format("%.2f", p.get("preco")) %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Quantidade *</label>
                            <input type="number" name="quantidade" min="1" required>
                        </div>
                        <div class="form-group">
                            <label>Data de Entrega *</label>
                            <input type="date" name="dataEntrega" required>
                        </div>
                        <div class="form-group">
                            <label>Status *</label>
                            <select name="status" required>
                                <option value="Pendente">Pendente</option>
                                <option value="Preparando">Preparando</option>
                                <option value="Entregue">Entregue</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Observações</label>
                        <textarea name="observacoes"></textarea>
                    </div>
                    <button type="submit" class="btn">Criar Pedido</button>
                </form>
            </div>

            <h2 class="section-title">Lista de Pedidos</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Produto</th>
                        <th>Quantidade</th>
                        <th>Valor Total</th>
                        <th>Data Entrega</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (pedidos.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="8" class="empty-state">Nenhum pedido cadastrado</td>
                        </tr>
                    <%
                        } else {
                            for (Map<String, Object> pedido : pedidos) {
                                String status = (String) pedido.get("status");
                                String statusClass = "status-pendente";
                                if ("Preparando".equals(status)) statusClass = "status-preparando";
                                if ("Entregue".equals(status)) statusClass = "status-entregue";
                    %>
                        <tr>
                            <td><%= pedido.get("id") %></td>
                            <td><%= pedido.get("cliente") %></td>
                            <td><%= pedido.get("produtoNome") %></td>
                            <td><%= pedido.get("quantidade") %> un</td>
                            <td>R$ <%= String.format("%.2f", pedido.get("valorTotal")) %></td>
                            <td><%= pedido.get("dataEntrega") %></td>
                            <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                            <td class="actions">
                                <a href="pedidos.jsp?action=excluir&id=<%= pedido.get("id") %>" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Tem certeza que deseja excluir este pedido?')">Excluir</a>
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