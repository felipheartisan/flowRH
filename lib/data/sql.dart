class Config{
  static const String sql = '''

-- Tabela `Funcionarios`
CREATE TABLE IF NOT EXISTS `Funcionarios` (
  idFuncionarios INTEGER PRIMARY KEY,
  `nome` TEXT,
  `data_nascimento` TEXT,
  `salario` TEXT,
  `cargo` TEXT,
  `departamento` TEXT,
  `cpf` TEXT,
  `rg` TEXT,
  `telefone` TEXT,
  `rua` TEXT,
  `numero_casa` TEXT,
  `bairro` TEXT,
  `cidade` TEXT,
  `email` TEXT
);

-- Tabela `Login`
CREATE TABLE IF NOT EXISTS `Login` (
  `usuario` INTEGER PRIMARY KEY,
  `token` TEXT UNIQUE NOT NULL
);

-- Tabela `Despesas`
CREATE TABLE IF NOT EXISTS `Despesas` (
  `idDespesas` INTEGER PRIMARY KEY,
  `valor` TEXT,
  `data` TEXT,
  `categoria` TEXT
);

-- Tabela `Receitas`
CREATE TABLE IF NOT EXISTS `Receitas` (
  `idReceitas` INTEGER PRIMARY KEY,
  `valor` TEXT,
  `data` TEXT,
  `categoria` TEXT
);

-- Tabela `Beneficios`
CREATE TABLE IF NOT EXISTS `Beneficios` (
  `idBeneficios` INTEGER PRIMARY KEY,
  `dependentes` TEXT,
  `descricao` TEXT
);

-- Tabela `Avaliacoes`
CREATE TABLE IF NOT EXISTS `Avaliacoes` (
  `idAvaliacoes` INTEGER PRIMARY KEY,
  `nota` TEXT,
  `cursos_feitos` TEXT,
  `cursos_interesse` TEXT,
  `atividades` TEXT,
  `mes_referencia` TEXT,
  `ano_referencia` TEXT,
  `Funcionarios_idFuncionarios` INTEGER,
  FOREIGN KEY (`Funcionarios_idFuncionarios`) REFERENCES `Funcionarios` (`idFuncionarios`)
);

-- Tabela `Beneficios_has_Funcionarios`
CREATE TABLE IF NOT EXISTS `Beneficios_has_Funcionarios` (
  `Beneficios_idBeneficios` INTEGER,
  `Funcionarios_idFuncionarios` INTEGER,
  PRIMARY KEY (`Beneficios_idBeneficios`, `Funcionarios_idFuncionarios`),
  FOREIGN KEY (`Beneficios_idBeneficios`) REFERENCES `Beneficios` (`idBeneficios`),
  FOREIGN KEY (`Funcionarios_idFuncionarios`) REFERENCES `Funcionarios` (`idFuncionarios`)
);

''';
}