-- répartition des festivals par région --
SELECT Rgion_principale_de_droulement, (count(nom_du_festival)/7882)*100 as pourcentage_de_festival_par_région
FROM new_schema.festival
group by Rgion_principale_de_droulement;

-- 5 premières régions où a eu lieu le plus grand nombrefestivals --
SELECT Rgion_principale_de_droulement, (count(nom_du_festival)/7882)*100 as pourcentage_de_festival
FROM new_schema.festival
group by Rgion_principale_de_droulement
order by pourcentage_de_festival desc
limit 5;
-- nombre de festival par discipline dominante --
select count(nom_du_festival) as nb_de_festival_par_disciple_dominante, discipline_dominante
from new_schema.festival
group by discipline_dominante;
-- les régions et leur discipline dominante --
select * from (SELECT Rgion_principale_de_droulement,Discipline_dominante, count(Discipline_dominante) as nb
, row_number() over (partition by Rgion_principale_de_droulement order by count(Discipline_dominante) desc) as rang1
FROM new_schema.festival
group by Rgion_principale_de_droulement,Discipline_dominante
order by Rgion_principale_de_droulement, nb desc) ranks
where rang1 =1;
-- classement des périodes où se déroulent les festivales--
select * from (select Priode_principale_de_droulement_du_festival, count(Priode_principale_de_droulement_du_festival) as nb_de_festival_se_déroulant_pendant_cette_période
, dense_rank() over (order by count(Priode_principale_de_droulement_du_festival ) desc)  as rang
from festival
group by Priode_principale_de_droulement_du_festival
order by nb_de_festival_se_déroulant_pendant_cette_période desc
limit 3) ranks;
-- 10 premières villes à accueillir des festivals--
select Commune_principale_de_droulement, count(commune_principale_de_droulement) as nb_de_fetival_par_commune
from festival
group by commune_principale_de_droulement
order by nb_de_fetival_par_commune desc
limit 10;

