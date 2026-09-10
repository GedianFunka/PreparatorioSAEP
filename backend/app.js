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

server.listen(5000, () => {
    console.log('Servidor rodando na porta 5000');
});