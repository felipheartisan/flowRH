class Config{
  static const String sql = '''
PRAGMA foreign_keys = ON;

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
  `idLogin` INTEGER PRIMARY KEY,
  `usuario` TEXT ,
  `token` TEXT 
);

-- Tabela `Cash`
CREATE TABLE IF NOT EXISTS `Cash` (
  `idCash` INTEGER PRIMARY KEY,
  `valor` TEXT,
  `data` TEXT,
  `categoria` TEXT,
  `descricao` TEXT
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
  `idFuncionarios` INTEGER,
  FOREIGN KEY (`idFuncionarios`) REFERENCES `Funcionarios` (`idFuncionarios`) ON DELETE RESTRICT
);

-- Tabela `Beneficios_has_Funcionarios`
CREATE TABLE IF NOT EXISTS `Beneficios_has_Funcionarios` (
  `id_beneficios_funcionarios` INTEGER PRIMARY KEY,
  `idBeneficios` INTEGER,
  `idFuncionarios` INTEGER,
  FOREIGN KEY (`idBeneficios`) REFERENCES `Beneficios` (`idBeneficios`) ON DELETE CASCADE,
  FOREIGN KEY (`idFuncionarios`) REFERENCES `Funcionarios` (`idFuncionarios`) ON DELETE CASCADE
);

''';
}