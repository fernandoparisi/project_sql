-- Vista 1
CREATE VIEW Vista_Materiales_Detalle AS
SELECT
    M.ID_MAT,
    M.TEX_MAT,
    M.STK_DISP,
    GC.GRU_COM AS Grupo_Compra,
    GA.GRU_ART AS Grupo_Articulo,
    A.NOM_ALM AS Nombre_Almacen,
    A.DIR_ALM AS Direccion_Almacen,
    UM.NOM_UM AS Unidad_Medida
FROM
    Materiales M
JOIN
    GruposCompras GC ON M.ID_GC = GC.ID_GC
JOIN
    GruposArticulos GA ON M.ID_ART = GA.ID_ART
JOIN
    Almacenes A ON M.ID_ALM = A.ID_ALM
JOIN
    UnidadesMedida UM ON M.ID_UM = UM.ID_UM;

SELECT * FROM Vista_Materiales_Detalle LIMIT 10; 

-- Vista 2
CREATE VIEW Vista_Ordenes_Trabajo_Extendida AS
SELECT
    OT.ID_OT,
    OT.COS_TOT,
    OT.FH_INI,
    OT.FH_FIN,
    COT.NOM_COT AS Clase_Orden_Trabajo,
    EQ.DEN AS Denominacion_Equipo,
    FEQ.NOM_FEQ AS Familia_Equipo,
    EQ.A_CON AS Año_Construccion 
FROM
    OrdenesTrabajo OT
JOIN
    ClasesOrdenTrabajo COT ON OT.ID_COT = COT.ID_COT
JOIN
    Equipos EQ ON OT.ID_EQ = EQ.ID_EQ
JOIN
    FamiliasEquipos FEQ ON EQ.ID_FEQ = FEQ.ID_FEQ;
    
SELECT * FROM Vista_Ordenes_Trabajo_Extendida LIMIT 10;

-- Vista 3
CREATE VIEW Vista_Documentos_Compras_Material AS
SELECT
    DC.ID_DC,
    DC.POS,
    DC.FEC_DOC,
    DC.CANT_PED,
    DC.PREC_NETO,
    MON.COD_MON AS Codigo_Moneda,
    M.TEX_MAT AS Material_Comprado,
    UM.NOM_UM AS Unidad_Medida,
    P.NOM_PROV AS Nombre_Proveedor,
    P.EML_PROV AS Email_Proveedor,
    GC.GRU_COM AS Grupo_Compra
FROM
    DocumentosCompras DC
JOIN
    Materiales M ON DC.ID_MAT = M.ID_MAT
JOIN
    Proveedores P ON DC.ID_PROV = P.ID_PROV
JOIN
    Monedas MON ON DC.ID_MON = MON.ID_MON
JOIN
    UnidadesMedida UM ON DC.ID_UM = UM.ID_UM
JOIN
    GruposCompras GC ON DC.ID_GC = GC.ID_GC;
    
SELECT * FROM Vista_Documentos_Compras_Material LIMIT 10;

-- Vista 4
CREATE VIEW Vista_Reservas_Material_OT AS
SELECT
    R.ID_RES,
    R.FEC_NEC,
    R.CANT_NEC,
    OT.ID_OT,
    M.TEX_MAT AS Material_Reservado,
    UM.NOM_UM AS Unidad_Medida,
    CMV.NOM_CMV AS Clase_Movimiento
FROM
    Reservas R
JOIN
    OrdenesTrabajo OT ON R.ID_OT = OT.ID_OT
JOIN
    Materiales M ON R.ID_MAT = M.ID_MAT
JOIN
    UnidadesMedida UM ON R.ID_UM = UM.ID_UM
JOIN
    ClasesMovimiento CMV ON R.ID_CMV = CMV.ID_CMV;
    
SELECT * FROM Vista_Reservas_Material_OT LIMIT 10;

-- Vista 5
CREATE VIEW Vista_Movimientos_Material_Proveedor AS
SELECT
    MOV.ID_MOV,
    MOV.CANT_MOV,
    MOV.FEC_MOV,
    M.TEX_MAT AS Material_Movido,
    UM.NOM_UM AS Unidad_Medida,
    P.NOM_PROV AS Nombre_Proveedor_Movimiento,
    P.EML_PROV AS Email_Proveedor_Movimiento,
    CMV.NOM_CMV AS Tipo_Movimiento
FROM
    Movimientos MOV
JOIN
    Materiales M ON MOV.ID_MAT = M.ID_MAT
JOIN
    UnidadesMedida UM ON MOV.ID_UM = UM.ID_UM
LEFT JOIN
    Proveedores P ON MOV.ID_PROV = P.ID_PROV
JOIN
    ClasesMovimiento CMV ON MOV.ID_CMV = CMV.ID_CMV;

SELECT * FROM Vista_Movimientos_Material_Proveedor LIMIT 10;
