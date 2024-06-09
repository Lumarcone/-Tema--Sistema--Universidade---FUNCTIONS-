-- funções e procedures 

DELIMITER //
CREATE PROCEDURE InserirCurso(
   IN p_Nome VARCHAR(100),
   IN P_AreaID INT
)
BEGIN
   INSERT INTO Cursos(Nome, AreaID) VALUES(p_Nome, p_AreaID);
END //

CREATE PROCEDURE selecionarCursos()
BEGIN
   SELECT c.CursoID, c.Nome AS Curso, a.Nome AS Area
   FROM Cursos c
   JOIN Areas a ON c.AreaID;
END //

CREATE FUNCTION ObterCursoID (
    p_NomeCurso VARCHAR(100),
    p_NomeArea VARCHAR(100)
) RETURNS INT
BEGIN 
    DECLARE v_CursoID INT;
    
    SELECT c.CursoID INTO v_CursoID
    FROM Cursos c
    JOIN Areas a ON c.AreadID = a.AreaID
    WHERE c.Nome = p_NomeCurso AND a.Nome = p_NomeArea;
    
    RETURN V_CursoID;
END //

CREATE PROCEDURE MatricularAluno (
    IN p_Nome VARCHAR(100),
    IN p_Sobrenome VARCHAR(100),
    IN p_CursoID INT
)
BEGIN
    DECLARE v_Email VARCHAR(100);
    DECLARE v_AlunoID INT;
    
    SET v_Email = CONCAT(p_Nome,'.', p_Sobrenome,'@dominio.com');
    
    INSERT INTO Alunos (Nome, Sobrenome, Email) VALUES(p_Nome, p_sobrenome, v_Email);
    SET v_AlunoID = LAST_INSERT_ID();
    
    -- verficar se o aluno está matriculado no curso
    
    IF NOT EXISTS (SELECT 1 FROM Matriculas WHERE AlunoID = v_AlunoID AND CursoID = p_CursoID) THEN
         INSERT INTO Matriculas (AlunoID, CursoID) VALUES (v_AlunoID, p_CursoID);
	END IF;
END //

DELIMITER ;



