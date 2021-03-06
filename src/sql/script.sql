--  "Java Proposal" em Window -> PreferÍncias -> Java -> Editor -> ContentAssist -> Advanced (da Grid Superior).

-- ---------------------------------------------------
--
-- SQL script generated by Execute Query.
-- Generated 8-Jan-2016 17:18:24
--
-- ---------------------------------------------------
--
-- Program:      estoque.sql
-- Description:  SQL create tables script.
-- Schema:       public
-- Database:     PostgreSQL
--

-- SELECT CURRVAL('IDPRODUTO');

-- SELECT NEXTVAL('IDPRODUTO');

-- SELECT SETVAL('IDPRODUTO', 2);

-- ---------------------------------------------------


CREATE TABLE Flag (
                IDFlag NUMERIC(18) NOT NULL PRIMARY KEY,
                Descricao VARCHAR(80) NOT NULL,
                NomeEntidade VARCHAR(80) NOT NULL,
                NomeAtributo VARCHAR(80) NOT NULL
);

CREATE TABLE TipoLocalizacaoFisica (
                IDTipoLocalizacaoFisica NUMERIC(18) NOT NULL PRIMARY KEY,
                Codigo NUMERIC(18),
                Descricao VARCHAR(80)
);


CREATE TABLE LocalizacaoFisica (
                IDLocalizacaoFisica NUMERIC(18) NOT NULL PRIMARY KEY,
                Codigo NUMERIC(18),
                Descricao VARCHAR(80),
                Capacidade NUMERIC(12,4),
                Status NUMERIC(18),
                IDTipoLocalizacaoFisica NUMERIC(18)
);


CREATE TABLE Permissao (
                IDPermissao NUMERIC(18) NOT NULL PRIMARY KEY,
                Codigo NUMERIC(18),
                Descricao VARCHAR(80)
);


CREATE TABLE Composicao (
                IDComposicao NUMERIC(18) NOT NULL PRIMARY KEY,
                Lote VARCHAR(20),
                Codigo NUMERIC(18),
                Descricao VARCHAR(80),
                Status NUMERIC(18),
                DataComposicao DATE,
                IDLocalizacaoFisica NUMERIC(18)
);


CREATE TABLE Usuario (
                IDUsuario NUMERIC(18) NOT NULL PRIMARY KEY,
                Login VARCHAR(80),
                Senha VARCHAR(80),
                Nome VARCHAR(80),
                Status NUMERIC(18),
                Email VARCHAR(80),
                DataCadastro DATE,
                IDPermissao NUMERIC(18)
);


CREATE TABLE Grupo (
                IDGrupo NUMERIC(18) NOT NULL PRIMARY KEY,
                Codigo NUMERIC(18),
                Descricao VARCHAR(80)
);


CREATE TABLE UnidadeMedida (
                IDUnidadeMedida NUMERIC(18) NOT NULL PRIMARY KEY,
                Descricao VARCHAR(80),
                Sigla VARCHAR(5)
);


CREATE TABLE Produto (
                IDProduto NUMERIC(18) NOT NULL PRIMARY KEY,
                Codigo NUMERIC(18),
                Status NUMERIC(18),
                Descricao VARCHAR(80),
                Estoque NUMERIC(12,4),
                EstoqueMinimo NUMERIC(12,4),
                ValorUnitarioEntrada NUMERIC(12,4),
                ValorUnitarioSaida NUMERIC(12,4),
                IDUnidadeMedida NUMERIC(18),
                IDGrupo NUMERIC(18),
                CodigoBarra VARCHAR(20),
                EstoqueMaximo NUMERIC(12,4),
                DataUltimaCompra DATE
);


CREATE TABLE ItemComposicao (
                IDItemComposicao NUMERIC(18) NOT NULL PRIMARY KEY,
                IDProduto NUMERIC(18),
                IDComposicao NUMERIC(18),
                Quantidade NUMERIC(12,4),
                Perda NUMERIC(12,4),
                CustoUnitario NUMERIC(12,4)
);


CREATE TABLE ProdutoResultante (
                IDProdutoResultante NUMERIC(18) NOT NULL PRIMARY KEY,
                Quantidadw NUMERIC(12,4),
                CustoUnitario NUMERIC(12,4),
                Lote VARCHAR(20),
                IDProduto NUMERIC(18),
                IDItemComposicao NUMERIC(18)
);


CREATE TABLE OrdemProducao (
                IDOrdemProducao NUMERIC(18) NOT NULL PRIMARY KEY,
                Numero NUMERIC(18),
                DataProducao DATE,
                DataFinalizacao DATE,
                QuantidadeEstimada NUMERIC(12,4),
                QuantidadeProduzida NUMERIC(12,4),
                IDProduto NUMERIC(18),
                IDUsuario NUMERIC(18)
);


CREATE TABLE PessoaJuridica (
                IDPessoaJuridica NUMERIC(18) NOT NULL PRIMARY KEY,
                RazaoSocial VARCHAR(80),
                NomeFantasia VARCHAR(80),
                CNPJ VARCHAR(20),
                IE VARCHAR(20)
);


CREATE TABLE PessoaFisica (
                IDPessoaFisica NUMERIC(18) NOT NULL PRIMARY KEY,
                Nome VARCHAR(80),
                Genero VARCHAR(80) NOT NULL,
                Nascimento DATE,
                CPF VARCHAR(20),
                RG VARCHAR(20),
                RGOrgaoEmissor VARCHAR(20),
                RGEmissao DATE
);


CREATE TABLE TipoPessoa (
                idTipoPessoa NUMERIC(18) NOT NULL PRIMARY KEY,
                Codigo NUMERIC(18),
                Descricao VARCHAR(70)
);


CREATE TABLE Estado (
                IDEstado NUMERIC(18) NOT NULL PRIMARY KEY,
                UF VARCHAR(2),
                Descricao VARCHAR(30)
);


CREATE TABLE Municipio (
                IDMunicipio NUMERIC(18) NOT NULL PRIMARY KEY,
                Descricao VARCHAR(80),
                Codigo NUMERIC(18),
                IDEstado NUMERIC(18)
);


CREATE TABLE Bairro (
                IDBairro NUMERIC(18) NOT NULL PRIMARY KEY,
                Descricao VARCHAR(80),
                IDMunicipio NUMERIC(18)
);


CREATE TABLE Logradouro (
                idLogradouro NUMERIC(18) NOT NULL PRIMARY KEY,
                Descricao VARCHAR(80),
                CEP VARCHAR(20),
                IDBairro NUMERIC(18)
);


CREATE TABLE Endereco (
                IDEndereco NUMERIC(18) NOT NULL PRIMARY KEY,
                Numero VARCHAR(18),
                Complemento VARCHAR(200),
                idLogradouro NUMERIC(18)
);


CREATE TABLE Pessoa (
                IDPessoa NUMERIC(18) NOT NULL PRIMARY KEY,
                Fone VARCHAR(20),
                IDEndereco NUMERIC(18),
                idTipoPessoa NUMERIC(18),
                IDPessoaFisica NUMERIC(18),
                IDPessoaJuridica NUMERIC(18)
);


ALTER TABLE LocalizacaoFisica ADD CONSTRAINT tipolocfistolocfis
FOREIGN KEY (IDTipoLocalizacaoFisica)
REFERENCES TipoLocalizacaoFisica (IDTipoLocalizacaoFisica)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Composicao ADD CONSTRAINT localizacaofisicatocomposicao
FOREIGN KEY (IDLocalizacaoFisica)
REFERENCES LocalizacaoFisica (IDLocalizacaoFisica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Usuario ADD CONSTRAINT permissaotousuario
FOREIGN KEY (IDPermissao)
REFERENCES Permissao (IDPermissao)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ItemComposicao ADD CONSTRAINT composicaotoitemcomposicao
FOREIGN KEY (IDComposicao)
REFERENCES Composicao (IDComposicao)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE OrdemProducao ADD CONSTRAINT usuariotoordemproducao
FOREIGN KEY (IDUsuario)
REFERENCES Usuario (IDUsuario)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Produto ADD CONSTRAINT grupotoproduto
FOREIGN KEY (IDGrupo)
REFERENCES Grupo (IDGrupo)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Produto ADD CONSTRAINT unidademedidatoproduto
FOREIGN KEY (IDUnidadeMedida)
REFERENCES UnidadeMedida (IDUnidadeMedida)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE OrdemProducao ADD CONSTRAINT produtotoordemproducao
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ItemComposicao ADD CONSTRAINT produtotoitemcomposicao
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ProdutoResultante ADD CONSTRAINT produtotoprodutoresultante
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ProdutoResultante ADD CONSTRAINT itemcomptoprodutoresult
FOREIGN KEY (IDItemComposicao)
REFERENCES ItemComposicao (IDItemComposicao)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT pessoajuridicatopessoa
FOREIGN KEY (IDPessoaJuridica)
REFERENCES PessoaJuridica (IDPessoaJuridica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT pessoafisicatopessoa
FOREIGN KEY (IDPessoaFisica)
REFERENCES PessoaFisica (IDPessoaFisica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT tipopessoatopessoa
FOREIGN KEY (idTipoPessoa)
REFERENCES TipoPessoa (idTipoPessoa)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Municipio ADD CONSTRAINT estadotomunicipio
FOREIGN KEY (IDEstado)
REFERENCES Estado (IDEstado)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Bairro ADD CONSTRAINT municipiotobairro
FOREIGN KEY (IDMunicipio)
REFERENCES Municipio (IDMunicipio)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Logradouro ADD CONSTRAINT bairrotologradouro
FOREIGN KEY (IDBairro)
REFERENCES Bairro (IDBairro)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Endereco ADD CONSTRAINT logradourotoendereco
FOREIGN KEY (idLogradouro)
REFERENCES Logradouro (idLogradouro)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT enderecotopessoa
FOREIGN KEY (IDEndereco)
REFERENCES Endereco (IDEndereco)
DEFERRABLE INITIALLY DEFERRED;

CREATE SEQUENCE IDBAIRRO;
CREATE SEQUENCE IDCOMPOSICAO;
CREATE SEQUENCE IDENDERECO;
CREATE SEQUENCE IDESTADO;
CREATE SEQUENCE IDFLAG;
CREATE SEQUENCE IDGRUPO;
CREATE SEQUENCE IDITEMCOMPOSICAO;
CREATE SEQUENCE IDLOCALIZACAOFISICA;
CREATE SEQUENCE IDLOGRADOURO;
CREATE SEQUENCE IDMUNICIPIO;
CREATE SEQUENCE IDORDEMPRODUCAO;
CREATE SEQUENCE IDPERMISSAO;
CREATE SEQUENCE IDPESSOA;
CREATE SEQUENCE IDPESSOAFISICA;
CREATE SEQUENCE IDPESSOAJURIDICA;
CREATE SEQUENCE IDPRODUTO;
CREATE SEQUENCE IDPRODUTORESULTANTE;
CREATE SEQUENCE IDTIPOLOCALIZACAO;
CREATE SEQUENCE IDTIPOPESSOA;
CREATE SEQUENCE IDUNIDADEMEDIDA;
CREATE SEQUENCE IDUSUARIO;
CREATE SEQUENCE IDENTRADA;
CREATE SEQUENCE IDSAIDA;



CREATE TABLE Flag (
                IDFlag NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                NomeEntidade VARCHAR(80) NOT NULL,
                NomeAtributo VARCHAR(80) NOT NULL,
                CONSTRAINT idflag PRIMARY KEY (IDFlag)
);


CREATE TABLE TipoLocalizacaoFisica (
                IDTipoLocalizacaoFisica NUMERIC(18) NOT NULL,
                Codigo NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                CONSTRAINT idtipolocalizacaofisica PRIMARY KEY (IDTipoLocalizacaoFisica)
);


CREATE TABLE LocalizacaoFisica (
                IDLocalizacaoFisica NUMERIC(18) NOT NULL,
                Codigo NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                Capacidade NUMERIC(12,4) NOT NULL,
                Status NUMERIC(18) NOT NULL,
                IDTipoLocalizacaoFisica NUMERIC(18) NOT NULL,
                CONSTRAINT idlocalizacaofisica PRIMARY KEY (IDLocalizacaoFisica)
);


CREATE TABLE Permissao (
                IDPermissao NUMERIC(18) NOT NULL,
                Codigo NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                CONSTRAINT idpermissao PRIMARY KEY (IDPermissao)
);


CREATE TABLE Composicao (
                IDComposicao NUMERIC(18) NOT NULL,
                Lote VARCHAR(20) NOT NULL,
                Codigo NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                Status NUMERIC(18) NOT NULL,
                DataComposicao DATE NOT NULL,
                IDLocalizacaoFisica NUMERIC(18) NOT NULL,
                CONSTRAINT idcomposicao PRIMARY KEY (IDComposicao)
);


CREATE TABLE Usuario (
                IDUsuario NUMERIC(18) NOT NULL,
                Login VARCHAR(80) NOT NULL,
                Senha VARCHAR(80) NOT NULL,
                Nome VARCHAR(80) NOT NULL,
                Status NUMERIC(18) NOT NULL,
                Email VARCHAR(80) NOT NULL,
                DataCadastro DATE NOT NULL,
                IDPermissao NUMERIC(18) NOT NULL,
                CONSTRAINT idusuario PRIMARY KEY (IDUsuario)
);


CREATE TABLE Grupo (
                IDGrupo NUMERIC(18) NOT NULL,
                Codigo NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                CONSTRAINT idgrupo PRIMARY KEY (IDGrupo)
);


CREATE TABLE UnidadeMedida (
                IDUnidadeMedida NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                Sigla VARCHAR(5) NOT NULL,
                CONSTRAINT idunidademedida PRIMARY KEY (IDUnidadeMedida)
);


CREATE TABLE Produto (
                IDProduto NUMERIC(18) NOT NULL,
                Status NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                Estoque NUMERIC(12,4) NOT NULL,
                EstoqueMinimo NUMERIC(12,4) NOT NULL,
                ValorUnitarioEntrada NUMERIC(12,4) NOT NULL,
                ValorUnitarioSaida NUMERIC(12,4) NOT NULL,
                IDUnidadeMedida NUMERIC(18) NOT NULL,
                IDGrupo NUMERIC(18) NOT NULL,
                CodigoBarra VARCHAR(20) NOT NULL,
                EstoqueMaximo NUMERIC(12,4) NOT NULL,
                DataUltimaCompra DATE NOT NULL,
                IDFlag NUMERIC(18) NOT NULL,
                CONSTRAINT idproduto PRIMARY KEY (IDProduto)
);


CREATE TABLE ItemComposicao (
                IDItemComposicao NUMERIC(18) NOT NULL,
                IDProduto NUMERIC(18) NOT NULL,
                IDComposicao NUMERIC(18) NOT NULL,
                Quantidade NUMERIC(12,4) NOT NULL,
                Perda NUMERIC(12,4) NOT NULL,
                CustoUnitario NUMERIC(12,4) NOT NULL,
                CONSTRAINT iditemcomposicao PRIMARY KEY (IDItemComposicao)
);


CREATE TABLE ProdutoResultante (
                IDProdutoResultante NUMERIC(18) NOT NULL,
                Quantidadw NUMERIC(12,4) NOT NULL,
                CustoUnitario NUMERIC(12,4) NOT NULL,
                Lote VARCHAR(20) NOT NULL,
                IDProduto NUMERIC(18) NOT NULL,
                IDItemComposicao NUMERIC(18) NOT NULL,
                CONSTRAINT idprodutoresultante PRIMARY KEY (IDProdutoResultante)
);


CREATE TABLE OrdemProducao (
                IDOrdemProducao NUMERIC(18) NOT NULL,
                Numero NUMERIC(18) NOT NULL,
                DataProducao DATE NOT NULL,
                DataFinalizacao DATE NOT NULL,
                QuantidadeEstimada NUMERIC(12,4) NOT NULL,
                QuantidadeProduzida NUMERIC(12,4) NOT NULL,
                IDProduto NUMERIC(18) NOT NULL,
                IDUsuario NUMERIC(18) NOT NULL,
                CONSTRAINT idordemproducao PRIMARY KEY (IDOrdemProducao)
);


CREATE TABLE PessoaJuridica (
                IDPessoaJuridica NUMERIC(18) NOT NULL,
                RazaoSocial VARCHAR(80) NOT NULL,
                NomeFantasia VARCHAR(80) NOT NULL,
                CNPJ VARCHAR(20) NOT NULL,
                IE VARCHAR(20) NOT NULL,
                CONSTRAINT idpessoajuridica PRIMARY KEY (IDPessoaJuridica)
);


CREATE TABLE PessoaFisica (
                IDPessoaFisica NUMERIC(18) NOT NULL,
                Nome VARCHAR(80) NOT NULL,
                Genero VARCHAR(80) NOT NULL,
                Nascimento DATE NOT NULL,
                CPF VARCHAR(20) NOT NULL,
                RG VARCHAR(20) NOT NULL,
                RGOrgaoEmissor VARCHAR(20),
                RGEmissao DATE,
                CONSTRAINT idpessoafisica PRIMARY KEY (IDPessoaFisica)
);


CREATE TABLE TipoPessoa (
                idTipoPessoa NUMERIC(18) NOT NULL,
                Codigo NUMERIC(18) NOT NULL,
                Descricao VARCHAR(70) NOT NULL,
                CONSTRAINT idtipopessoa PRIMARY KEY (idTipoPessoa)
);


CREATE TABLE Estado (
                IDEstado NUMERIC(18) NOT NULL,
                UF VARCHAR(2),
                Descricao VARCHAR(30),
                CONSTRAINT idestado PRIMARY KEY (IDEstado)
);


CREATE TABLE Municipio (
                IDMunicipio NUMERIC(18) NOT NULL,
                Descricao VARCHAR NOT NULL,
                Codigo INTEGER,
                IDEstado NUMERIC(18) NOT NULL,
                CONSTRAINT idmunicipio PRIMARY KEY (IDMunicipio)
);


CREATE TABLE Bairro (
                IDBairro NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                IDMunicipio NUMERIC(18) NOT NULL,
                CONSTRAINT idbairro PRIMARY KEY (IDBairro)
);


CREATE TABLE Logradouro (
                idLogradouro NUMERIC(18) NOT NULL,
                Descricao VARCHAR(80) NOT NULL,
                CEP VARCHAR(20) NOT NULL,
                IDBairro NUMERIC(18) NOT NULL,
                CONSTRAINT idlogradouro PRIMARY KEY (idLogradouro)
);


CREATE TABLE Endereco (
                IDEndereco NUMERIC(18) NOT NULL,
                Numero VARCHAR(18) NOT NULL,
                Complemento VARCHAR(200),
                idLogradouro NUMERIC(18) NOT NULL,
                CONSTRAINT idendereco PRIMARY KEY (IDEndereco)
);


CREATE TABLE Pessoa (
                IDPessoa NUMERIC(18) NOT NULL,
                Fone VARCHAR(20),
                IDEndereco NUMERIC(18) NOT NULL,
                idTipoPessoa NUMERIC(18) NOT NULL,
                IDPessoaFisica NUMERIC(18) NOT NULL,
                IDPessoaJuridica NUMERIC(18) NOT NULL,
                CONSTRAINT idpessoa PRIMARY KEY (IDPessoa)
);


CREATE TABLE Saida (
                IDSaida NUMERIC(18) NOT NULL primary key,
                IDPessoa NUMERIC(18),
                IDProduto NUMERIC(18),
                Numero NUMERIC(18),
                DataSaida DATE,
                Quantidade NUMERIC(12,4)
);


CREATE TABLE Entrada (
                IDEntrada NUMERIC(18) NOT NULL primary key,
                IDPessoa NUMERIC(18),
                IDProduto NUMERIC(18),
                Numero NUMERIC(18),
                DataEntrada DATE,
                Quantidade NUMERIC(12,4)
);


ALTER TABLE Produto ADD CONSTRAINT flagtoproduto
FOREIGN KEY (IDFlag)
REFERENCES Flag (IDFlag)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE LocalizacaoFisica ADD CONSTRAINT tipolocfistolocfis
FOREIGN KEY (IDTipoLocalizacaoFisica)
REFERENCES TipoLocalizacaoFisica (IDTipoLocalizacaoFisica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Composicao ADD CONSTRAINT localizacaofisicatocomposicao
FOREIGN KEY (IDLocalizacaoFisica)
REFERENCES LocalizacaoFisica (IDLocalizacaoFisica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Usuario ADD CONSTRAINT permissaotousuario
FOREIGN KEY (IDPermissao)
REFERENCES Permissao (IDPermissao)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ItemComposicao ADD CONSTRAINT composicaotoitemcomposicao
FOREIGN KEY (IDComposicao)
REFERENCES Composicao (IDComposicao)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE OrdemProducao ADD CONSTRAINT usuariotoordemproducao
FOREIGN KEY (IDUsuario)
REFERENCES Usuario (IDUsuario)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Produto ADD CONSTRAINT grupotoproduto
FOREIGN KEY (IDGrupo)
REFERENCES Grupo (IDGrupo)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Produto ADD CONSTRAINT unidademedidatoproduto
FOREIGN KEY (IDUnidadeMedida)
REFERENCES UnidadeMedida (IDUnidadeMedida)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE OrdemProducao ADD CONSTRAINT produtotoordemproducao
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ItemComposicao ADD CONSTRAINT produtotoitemcomposicao
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ProdutoResultante ADD CONSTRAINT produtotoprodutoresultante
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Entrada ADD CONSTRAINT produtotoentrada
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Saida ADD CONSTRAINT produtotosaida
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ProdutoResultante ADD CONSTRAINT itemcomptoprodutoresult
FOREIGN KEY (IDItemComposicao)
REFERENCES ItemComposicao (IDItemComposicao)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT pessoajuridicatopessoa
FOREIGN KEY (IDPessoaJuridica)
REFERENCES PessoaJuridica (IDPessoaJuridica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT pessoafisicatopessoa
FOREIGN KEY (IDPessoaFisica)
REFERENCES PessoaFisica (IDPessoaFisica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT tipopessoatopessoa
FOREIGN KEY (idTipoPessoa)
REFERENCES TipoPessoa (idTipoPessoa)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Municipio ADD CONSTRAINT estadotomunicipio
FOREIGN KEY (IDEstado)
REFERENCES Estado (IDEstado)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Bairro ADD CONSTRAINT municipiotobairro
FOREIGN KEY (IDMunicipio)
REFERENCES Municipio (IDMunicipio)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Logradouro ADD CONSTRAINT bairrotologradouro
FOREIGN KEY (IDBairro)
REFERENCES Bairro (IDBairro)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Endereco ADD CONSTRAINT logradourotoendereco
FOREIGN KEY (idLogradouro)
REFERENCES Logradouro (idLogradouro)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT enderecotopessoa
FOREIGN KEY (IDEndereco)
REFERENCES Endereco (IDEndereco)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Entrada ADD CONSTRAINT pessoatoentrada
FOREIGN KEY (IDPessoa)
REFERENCES Pessoa (IDPessoa)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Saida ADD CONSTRAINT pessoatosaida
FOREIGN KEY (IDPessoa)
REFERENCES Pessoa (IDPessoa)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Saida ADD CONSTRAINT produtotosaida
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Entrada ADD CONSTRAINT produtotoentrada
FOREIGN KEY (IDProduto)
REFERENCES Produto (IDProduto)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT pessoatopessoafisica
FOREIGN KEY (IDPessoaFisica)
REFERENCES PessoaFisica (IDPessoaFisica)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Pessoa ADD CONSTRAINT pessoatopessoajuridica
FOREIGN KEY (IDPessoaJuridica)
REFERENCES PessoaJuridica (IDPessoaJuridica)
DEFERRABLE INITIALLY DEFERRED;

insert into usuario values (nextval('idusuario'), 1, 'LFeJ2tb/8s8GZvpMOTEqRA==', 'usuario', 0, null, current_date,0);


ALTER TABLE PESSOA ADD STATUS NUMERIC(18);