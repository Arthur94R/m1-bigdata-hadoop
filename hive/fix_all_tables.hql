USE accidents_moto;

-- Corriger usagers
DROP TABLE IF EXISTS usagers;
CREATE EXTERNAL TABLE usagers (
    Num_Acc STRING,
    place INT,
    catu INT,
    grav INT,
    sexe INT,
    trajet INT,
    secu INT,
    locp INT,
    actp INT,
    etatp INT,
    an_nais INT,
    num_veh STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/accidents/usagers/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Corriger lieux
DROP TABLE IF EXISTS lieux;
CREATE EXTERNAL TABLE lieux (
    Num_Acc STRING,
    catr INT,
    voie STRING,
    v1 INT,
    v2 STRING,
    circ INT,
    nbv INT,
    pr INT,
    pr1 INT,
    vosp INT,
    prof INT,
    plan INT,
    lartpc INT,
    larrout INT,
    surf INT,
    infra INT,
    situ INT,
    env1 STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/accidents/lieux/'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Vérifications finales
SELECT COUNT(*) as nb_usagers FROM usagers;
SELECT COUNT(*) as nb_lieux FROM lieux;

SHOW TABLES;
