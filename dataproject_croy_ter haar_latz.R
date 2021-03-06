# Frage: Welche Artisten sind in den meisten L�ndern vertreten (am internationalsten)?


# Die bereits installierten und nun n�tigen packages aus der library laden

library(dbplyr)
library(dplyr)
library(RSQLite)

# Die Datei chinnok.db laden und dem K�rzel "con" zuweisen

setwd("c:/")
con<-dbConnect(SQLite(),dbname="chinook.db")
dbListTables(con)

# Die f�nf zur L�sung der Aufgabe ben�tigten Tabellen als "albums", "artists", "tracks", "invoice_items" bzw. "invoices" definieren

albums <- con %>% tbl("albums")
artists <- con %>% tbl("artists")
tracks <- con %>% tbl("tracks")
invoice_items <- con %>% tbl("invoice_items")
invoices <- con %>% tbl("invoices")

# Wir joinen die Tabelle albums mit den Tabellen artists, tracks, invoice_items und invoices, um �ber diese Reihe artistID aus der Tabelle artists mit BillingCountry aus der Tabelle invoiceID verkn�pfen zu k�nnen

data <- albums %>%
  inner_join(artists, by = "ArtistId") %>%
  inner_join(tracks, by = "AlbumId") %>%
  inner_join(invoice_items, by = "TrackId") %>%
  inner_join(invoices, by = "InvoiceId") %>%
  
  # Wir w�hlen die Spalten "Name.x" und "BillingCountry" aus
  
  select(Name.x, BillingCountry) %>%
  
  # Durch den Befehl distinct entfernen wir zeilenweise Duplikate
  
  distinct(Name.x, BillingCountry) %>%
  
  # Wir benennen jedes Land in die Zahl 1 um, und machen sie somit summierbar
  
  summarise(Name.x, BillingCountry=1) %>%
  
  # Wir gruppieren nach der Spalte "Name.x" 
  
  group_by(Name.x) %>%
  
  #Wir summieren die Anzahl der BillingCountries f�r einen jeden Artisten   
  
  summarize(sum(BillingCountry)) %>%
  
  # Wir erhalten eine Tabelle, die den einzelnen Artisten (unter der Spalte Name.x aufgef�hrt) die Anzahl der L�nder angibt, in denen sie vertreten sind
  
  View