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
    <title>Fornecedores - Pão Di Mel</title>
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
            <h1>Gestão de Fornecedores</h1>
            <a href="index.jsp" class="btn-voltar">← Voltar ao Menu</a>
        </div>

        <div class="content">
            <h2 class="section-title">Cadastrar Fornecedor</h2>
            
            <div class="form-container">
                <form method="post" action="fornecedores.jsp">
                    <input type="hidden" name="action" value="adicionar">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Nome da Empresa *</label>
                            <input type="text" name="nome" required>
                        </div>
                        <div class="form-group">
                            <label>CNPJ *</label>
                            <input type="text" name="cnpj" required>
                        </div>
                        <div class="form-group">
                            <label>Telefone *</label>
                            <input type="tel" name="telefone" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Email *</label>
                            <input type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Categoria de Produtos *</label>
                            <select name="categoria" required>
                                <option value="">Selecione...</option>
                                <option value="Ingredientes">Ingredientes</option>
                                <option value="Embalagens">Embalagens</option>
                                <option value="Equipamentos">Equipamentos</option>
                                <option value="Matéria-Prima">Matéria-Prima</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Endereço</label>
                        <textarea name="endereco"></textarea>
                    </div>
                    <button type="submit" class="btn">Cadastrar Fornecedor</button>
                </form>
            </div>

            <h2 class="section-title">Lista de Fornecedores</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>CNPJ</th>
                        <th>Telefone</th>
                        <th>Email</th>
                        <th>Categoria</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Map<String, Object>> fornecedores = (List<Map<String, Object>>) session.getAttribute("fornecedores");
                        
                        if (fornecedores == null) {
                            fornecedores = new ArrayList<Map<String, Object>>();
                            
                            // Dados de exemplo
                            Map<String, Object> f1 = new HashMap<String, Object>();
                            f1.put("id", 1);
                            f1.put("nome", "Distribuidora Doce Sabor");
                            f1.put("cnpj", "12.345.678/0001-90");
                            f1.put("telefone", "(11) 98765-4321");
                            f1.put("email", "contato@docesabor.com.br");
                            f1.put("categoria", "Ingredientes");
                            f1.put("endereco", "Rua das Flores, 123 - São Paulo/SP");
                            fornecedores.add(f1);
                            
                            Map<String, Object> f2 = new HashMap<String, Object>();
                            f2.put("id", 2);
                            f2.put("nome", "Embalagens Premium");
                            f2.put("cnpj", "98.765.432/0001-10");
                            f2.put("telefone", "(11) 91234-5678");
                            f2.put("email", "vendas@embpremium.com.br");
                            f2.put("categoria", "Embalagens");
                            f2.put("endereco", "Av. Industrial, 456 - São Paulo/SP");
                            fornecedores.add(f2);
                            
                            session.setAttribute("fornecedores", fornecedores);
                        }
                        
                        // Processar adição de fornecedor
                        String action = request.getParameter("action");
                        if ("adicionar".equals(action)) {
                            int novoId = fornecedores.size() + 1;
                            Map<String, Object> novoFornecedor = new HashMap<String, Object>();
                            novoFornecedor.put("id", novoId);
                            novoFornecedor.put("nome", request.getParameter("nome"));
                            novoFornecedor.put("cnpj", request.getParameter("cnpj"));
                            novoFornecedor.put("telefone", request.getParameter("telefone"));
                            novoFornecedor.put("email", request.getParameter("email"));
                            novoFornecedor.put("categoria", request.getParameter("categoria"));
                            novoFornecedor.put("endereco", request.getParameter("endereco"));
                            fornecedores.add(novoFornecedor);
                            session.setAttribute("fornecedores", fornecedores);
                            response.sendRedirect("fornecedores.jsp");
                        }
                        
                        // Processar exclusão - SEM LAMBDA
                        if ("excluir".equals(action)) {
                            int idExcluir = Integer.parseInt(request.getParameter("id"));
                            Iterator<Map<String, Object>> iterator = fornecedores.iterator();
                            while (iterator.hasNext()) {
                                Map<String, Object> f = iterator.next();
                                if ((Integer)f.get("id") == idExcluir) {
                                    iterator.remove();
                                    break;
                                }
                            }
                            session.setAttribute("fornecedores", fornecedores);
                            response.sendRedirect("fornecedores.jsp");
                        }
                        
                        if (fornecedores.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="7" class="empty-state">Nenhum fornecedor cadastrado</td>
                        </tr>
                    <%
                        } else {
                            for (Map<String, Object> fornecedor : fornecedores) {
                    %>
                        <tr>
                            <td><%= fornecedor.get("id") %></td>
                            <td><%= fornecedor.get("nome") %></td>
                            <td><%= fornecedor.get("cnpj") %></td>
                            <td><%= fornecedor.get("telefone") %></td>
                            <td><%= fornecedor.get("email") %></td>
                            <td><%= fornecedor.get("categoria") %></td>
                            <td class="actions">
                                <a href="fornecedores.jsp?action=excluir&id=<%= fornecedor.get("id") %>" 
                                   class="btn btn-delete" 
                                   onclick="return confirm('Tem certeza que deseja excluir este fornecedor?')">Excluir</a>
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