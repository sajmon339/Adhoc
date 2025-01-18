DROP TABLE IF EXISTS dbo.StatusTypes;
DROP TABLE IF EXISTS dbo.BudgetTypes;

CREATE TABLE dbo.StatusTypes (
    status_value VARCHAR(20) PRIMARY KEY
);

CREATE TABLE dbo.BudgetTypes (
    budget_value VARCHAR(10) PRIMARY KEY
);

INSERT INTO dbo.StatusTypes (status_value)
VALUES ('nowy'), ('w trakcie'), ('zakończony'), ('anulowany');

INSERT INTO dbo.BudgetTypes (budget_value)
VALUES ('lokalny'), ('centralny');
GO

DROP TABLE IF EXISTS dbo.Projekty;

CREATE TABLE dbo.Projekty (
    proj_id INT PRIMARY KEY IDENTITY,
    proj_nazwa VARCHAR(20),
    proj_status VARCHAR(20),
    proj_budzet VARCHAR(10),
    FOREIGN KEY (proj_status) REFERENCES dbo.StatusTypes(status_value),
    FOREIGN KEY (proj_budzet) REFERENCES dbo.BudgetTypes(budget_value)
);

INSERT INTO dbo.Projekty (proj_nazwa, proj_status, proj_budzet)
VALUES
('Projekt Alpha', 'nowy', 'lokalny'),
('Projekt Beta', 'w trakcie', 'centralny'),
('Projekt Gamma', 'zakończony', 'lokalny'),
('Projekt Delta', 'anulowany', 'centralny'),
('Projekt Epsilon', 'nowy', 'lokalny'),
('Projekt Zeta', 'w trakcie', 'centralny'),
('Projekt Eta', 'zakończony', 'lokalny'),
('Projekt Theta', 'anulowany', 'lokalny'),
('Projekt Iota', 'nowy', 'centralny'),
('Projekt Kappa', 'w trakcie', 'lokalny'),
('Projekt Lambda', 'zakończony', 'centralny');

SELECT * FROM dbo.StatusTypes;

SELECT * FROM dbo.BudgetTypes;

SELECT p.proj_id, p.proj_nazwa, p.proj_status, p.proj_budzet
FROM dbo.Projekty p;

