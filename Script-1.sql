-- Criação da tabela Professor
CREATE TABLE Professor (
    professor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    titulacao VARCHAR(50)
);

-- Criação da tabela Curso
CREATE TABLE Curso (
    curso_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_curso VARCHAR(150) NOT NULL,
    duracao INTEGER NOT NULL,  -- Duração em anos
    grau_academico VARCHAR(50) NOT NULL -- Exemplo: Bacharelado, Licenciatura, etc.
);

-- Criação da tabela Aluno
CREATE TABLE Aluno (
    aluno_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE, -- Número de matrícula único
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    curso_id INTEGER NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id)
);

-- Criação da tabela Disciplina
CREATE TABLE Disciplina (
    disciplina_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_disciplina VARCHAR(150) NOT NULL,
    carga_horaria INTEGER NOT NULL, -- Carga horária total da disciplina
    curso_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES Curso(curso_id),
    FOREIGN KEY (professor_id) REFERENCES Professor(professor_id)
);

-- Criação da tabela Matricula
CREATE TABLE Matricula (
    matricula_id INTEGER PRIMARY KEY AUTOINCREMENT,
    aluno_id INTEGER NOT NULL,
    disciplina_id INTEGER NOT NULL,
    semestre INTEGER NOT NULL, -- Exemplo: 1 ou 2
    ano INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL, -- Exemplo: Cursando, Aprovado, Reprovado, etc.
    FOREIGN KEY (aluno_id) REFERENCES Aluno(aluno_id),
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id)
);

-- Criação da tabela Historico_Escolar
CREATE TABLE Historico_Escolar (
    historico_id INTEGER PRIMARY KEY AUTOINCREMENT,
    aluno_id INTEGER NOT NULL,
    disciplina_id INTEGER NOT NULL,
    nota_final REAL, -- Nota final do aluno
    frequencia REAL, -- Frequência do aluno (em percentual)
    semestre INTEGER NOT NULL, -- Exemplo: 1 ou 2
    ano INTEGER NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES Aluno(aluno_id),
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id)
);

SELECT a.nome, a.sobrenome, c.nome_curso AS nomeCurso, a.data_nascimento
FROM Aluno a 
JOIN Curso c ON a.curso_id = c.curso_id 
WHERE a.data_nascimento < '2000-01-01' AND c.nome_curso = 'Engenharia Civil'
;

SELECT d.nome_disciplina, d.carga_horaria, p.nome, p.sobrenome
FROM Disciplina d 
JOIN Professor p ON d.professor_id = p.professor_id 
WHERE d.carga_horaria > 90 AND p.titulacao = 'Mestre'
;

SELECT a.nome, a.sobrenome, d.nome_disciplina, he.nota_final 
FROM Aluno a 
LEFT JOIN Disciplina d ON d.curso_id = a.curso_id 
JOIN Historico_Escolar he ON d.disciplina_id = he.disciplina_id
WHERE he.nota_final <= 3.0 AND d.nome_disciplina IN('Cálculo I','Física I')
ORDER BY d.nome_disciplina DESC
;

SELECT a.nome, d.nome_disciplina, he.frequencia
FROM Aluno AS A
JOIN Historico_Escolar AS HE ON A.aluno_id = HE.aluno_id
JOIN Disciplina AS D ON HE.disciplina_id = D.disciplina_id 
WHERE he.frequencia < 75 AND he.ano BETWEEN 2022 AND 2024
;

SELECT a.nome, a.sobrenome, d.nome_disciplina, m.ano
FROM Aluno AS A
JOIN Matricula AS M ON A.aluno_id = M.aluno_id
JOIN Disciplina AS D ON M.disciplina_id = D.disciplina_id
WHERE m.ano < 2021 AND m.status = 'Aprovado'
;

SELECT d.nome_disciplina, d.carga_horaria
FROM Disciplina d
ORDER BY d.nome_disciplina
;
