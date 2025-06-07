USE proyecto_sql;

-- Tabla: Grupos de compras
CREATE TABLE GruposCompras (
    ID_GC INT PRIMARY KEY,
    GRU_COM VARCHAR(50)
);

-- Tabla: Grupos de artículos
CREATE TABLE GruposArticulos (
    ID_ART INT PRIMARY KEY,
    GRU_ART VARCHAR(50)
);

-- Tabla: Almacenes
CREATE TABLE Almacenes (
    ID_ALM INT PRIMARY KEY,
    NOM_ALM VARCHAR(50),
    DIR_ALM VARCHAR(100)
);

-- Tabla: Proveedores
CREATE TABLE Proveedores (
    ID_PROV INT PRIMARY KEY,
    NOM_PROV VARCHAR(100),
    DIR_PROV VARCHAR(100),
    TEL_PROV VARCHAR(20),
    EML_PROV VARCHAR(100)
);

-- Tabla: Clases de movimiento
CREATE TABLE ClasesMovimiento (
    ID_CMV INT PRIMARY KEY,
    NOM_CMV VARCHAR(50)
);

-- Tabla: Unidades de medida
CREATE TABLE UnidadesMedida (
    ID_UM INT PRIMARY KEY,
    NOM_UM VARCHAR(50)
);

-- Tabla: Fabricantes
CREATE TABLE Fabricantes (
    ID_FAB INT PRIMARY KEY,
    NOM_FAB VARCHAR(50),
    DIR_FAB VARCHAR(100),
    TEL_FAB VARCHAR(20),
    EML_FAB VARCHAR(100)
);

-- Tabla: Familias equipos
CREATE TABLE FamiliasEquipos (
    ID_FEQ INT PRIMARY KEY,
    NOM_FEQ VARCHAR(50)
);

-- Tabla: Equipos
CREATE TABLE Equipos (
    ID_EQ INT PRIMARY KEY,
    DEN VARCHAR(50),
    A_CON INT,
    ID_FAB INT,
    ID_FEQ INT,
    FOREIGN KEY (ID_FAB) REFERENCES Fabricantes(ID_FAB),
    FOREIGN KEY (ID_FEQ) REFERENCES FamiliasEquipos(ID_FEQ)
);

-- Tabla: Clases orden de trabajo
CREATE TABLE ClasesOrdenTrabajo (
    ID_COT INT PRIMARY KEY,
    NOM_COT VARCHAR(50)
);

-- Tabla: Ordenes de trabajo
CREATE TABLE OrdenesTrabajo (
    ID_OT INT PRIMARY KEY,
    COS_TOT DECIMAL(10,2),
    FH_INI DATETIME,
    FH_FIN DATETIME,
    ID_COT INT,
    ID_FEQ INT,
    ID_EQ INT,
    FOREIGN KEY (ID_COT) REFERENCES ClasesOrdenTrabajo(ID_COT),
    FOREIGN KEY (ID_FEQ) REFERENCES FamiliasEquipos(ID_FEQ),
    FOREIGN KEY (ID_EQ) REFERENCES Equipos(ID_EQ)
);

-- Tabla: Materiales
CREATE TABLE Materiales (
    ID_MAT INT PRIMARY KEY,
    TEX_MAT VARCHAR(100),
    STK_DISP INT,
    ID_GC INT,
    ID_ART INT,
    ID_ALM INT,
    ID_UM INT,
    FOREIGN KEY (ID_GC) REFERENCES GruposCompras(ID_GC),
    FOREIGN KEY (ID_ART) REFERENCES GruposArticulos(ID_ART),
    FOREIGN KEY (ID_ALM) REFERENCES Almacenes(ID_ALM),
    FOREIGN KEY (ID_UM) REFERENCES UnidadesMedida(ID_UM)
);

--  Nueva tabla: Monedas (normalizada)
CREATE TABLE Monedas (
    ID_MON INT AUTO_INCREMENT PRIMARY KEY,
    CODIGO CHAR(3) UNIQUE NOT NULL,     -- e.g. 'USD', 'ARS', 'EUR'
    DESCRIPCION VARCHAR(50)             -- e.g. 'Dólares estadounidenses'
);

-- Tabla: Documentos de compras (modificada)
CREATE TABLE DocumentosCompras (
    ID_DC INT,
    POS INT,
    FEC_DOC DATE,
    CANT_PED INT,
    PREC_NETO DECIMAL(10,2),
    ID_MON INT,                                 -- Se reemplaza MONEDA
    ID_MAT INT,
    ID_PROV INT,
    ID_GC INT,
    ID_UM INT,
    PRIMARY KEY (ID_DC, POS),
    INDEX (ID_DC),
    INDEX (POS),
    FOREIGN KEY (ID_MON) REFERENCES Monedas(ID_MON),
    FOREIGN KEY (ID_MAT) REFERENCES Materiales(ID_MAT),
    FOREIGN KEY (ID_PROV) REFERENCES Proveedores(ID_PROV),
    FOREIGN KEY (ID_GC) REFERENCES GruposCompras(ID_GC),
    FOREIGN KEY (ID_UM) REFERENCES UnidadesMedida(ID_UM)
);

-- Tabla: Reservas (eliminado campo derivado CANT_DIF)
CREATE TABLE Reservas (
    ID_RES INT PRIMARY KEY,
    FEC_NEC DATE,
    CANT_NEC INT,
    ID_OT INT,
    ID_MAT INT,
    ID_UM INT,
    ID_CMV INT,
    FOREIGN KEY (ID_OT) REFERENCES OrdenesTrabajo(ID_OT),
    FOREIGN KEY (ID_MAT) REFERENCES Materiales(ID_MAT),
    FOREIGN KEY (ID_UM) REFERENCES UnidadesMedida(ID_UM),
    FOREIGN KEY (ID_CMV) REFERENCES ClasesMovimiento(ID_CMV)
);

-- Tabla: Movimientos
CREATE TABLE Movimientos (
    ID_MOV INT PRIMARY KEY,
    CANT_MOV INT,
    FEC_MOV DATE,
    ID_MAT INT,
    ID_UM INT,
    ID_PROV INT,
    FOREIGN KEY (ID_MAT) REFERENCES Materiales(ID_MAT),
    FOREIGN KEY (ID_UM) REFERENCES UnidadesMedida(ID_UM),
    FOREIGN KEY (ID_PROV) REFERENCES Proveedores(ID_PROV)
);
