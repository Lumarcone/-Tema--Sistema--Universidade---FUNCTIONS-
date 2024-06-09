DELIMITER //

CREATE PROCEDURE InserirAlunosAleatorios()
BEGIN
    DECLARE v_Index INT DEFAULT 1;
    DECLARE v_Nome VARCHAR(100);
    DECLARE v_Sobrenome VARCHAR(100);
    DECLARE v_CursoID INT;
    
    WHILE v_Index <= 200 DO
        SET v_Nome = CONCAT('Aluno', v_Index);
        SET v_Sobrenome = CONCAT('Sobrenome', v_Index);
        SET v_CursoID = FLOOR(1 + (RAND() * 25));
        
        CALL MatricularAluno(v_Nome, v_Sobrenome, v_CursoID);
        
        SET v_Index = v_Index + 1;
    END WHILE;
END //

DELIMITER ;

-- Chamar a procedure para inserir os alunos
CALL InserirAlunosAleatorios();

select*from alunos;