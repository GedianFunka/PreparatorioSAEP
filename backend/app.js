const express = require('express');
const cors = require('cors');
const connection = require('./db')

const server = express();
server.use(cors());
server.use(express.json());

// Atende a RF04 (listar produtos)
server.get('/produtos', (req, res) => {
    const sql = 'SELECT * FROM PRODUTO';

    connection.query(sql, (erro, resultado) => {
        if(erro){
            return res.status(500).json({ erro: erro.message });
        }
        res.json(resultado);
    });
});

//Atende ao RF05 (listar produtos em ordem alfabética)
server.get('/produtos/ordenados', (req, res) => {
    const sql = 'SELECT * FROM PRODUTO ORDER BY NOME ASC';

    connection.query(sql, (erro, resultado) => {
        if(erro){
            return res.status(500).json({ erro: erro.message });
        }
        res.json(resultado);
    });
});

//Rota: GET /produtos/:id
server.get('/produtos/:id', (req, res)=>{
    const {id} = req.params;

    const sql = 'SELECT * FROM PRODUTO WHERE id_produto = ?'

    connection.query(sql, [id],  (erro, resultado) => {
        if(erro){
            return res.status(500).json({erro: erro.message});
        }
        res.json(resultado[0]);
    });
});

//Rota: GET /produtos/busca/:nomes
server.get('/produtos/busca/:nomes', (req, res) => {
    const sql = 'SELECT * FROM PRODUTO WHERE nome LIKE ?';

    const termoBusca = '%' + req.params.nomes + '%';

    connection.query(sql, [termoBusca], (erro, resultado) => {
        if(erro) {
            return res.status(500).json({ erro: erro.message });
        }
        res.json(resultado);
    });
});

//Rota de Cadastrar Produto
server.post('/produtos', (req, res) => {
    const{nome, cor, textura, peso, unidade_medida, aplicacao, data_validade, estoque_minimo, estoque_atual, preco_unitario, id_categoria} = req.body;

    if(nome == null || peso == null || unidade_medida == null || aplicacao == null || data_validade == null || estoque_minimo == null || estoque_atual == null || preco_unitario == null || id_categoria == null){
        return res.status(400).json({erro: 'Todos os campos são obrigatórios'});
    }

    const sql = 'INSERT INTO PRODUTO (nome, cor, textura, peso, unidade_medida, aplicacao, data_validade, estoque_minimo, estoque_atual, preco_unitario, id_categoria) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    
    connection.query(sql, [nome, cor, textura, peso, unidade_medida, aplicacao, data_validade, estoque_minimo, estoque_atual, preco_unitario, id_categoria], (erro, resultado) => {
        
        if(erro){
            return res.status(500).json({erro: erro.message});
        }

    res.json({mensagem: 'Produto cadastrado com sucesso', id_produto: resultado.insertId});

    })
})

server.listen(5000, () => {
    console.log('Servidor rodando na porta 5000');
});