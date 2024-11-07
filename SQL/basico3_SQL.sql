ALTER TABLE periodicos ADD CONSTRAINT fk_editora_periodico 
FOREIGN KEY (id_editora) REFERENCES editora(id);