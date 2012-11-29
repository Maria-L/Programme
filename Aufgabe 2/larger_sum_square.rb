# Determines the two biggest numbers of three, squares them and sums them up in the end.
#
#larger_sum_square ::= (val1, val2, val3) ::
#Int x Int x Int -> Int
#
#Test{
#     (2,4,6) => 52, (4,2,6) => 52, (6,4,2) => 52, (2,2,2) => 8,
#     (2,2,4) => 20, (-4,-2,6) => 40
#     ('2',4,6) => Err, (2,'4',6) => Err, (2,4,'6') => Err,
#     (2.1,4,6) => Err, (2,4.1,6) => Err, (2,4,6.1) => Err }

require_relative'../Extensions/ext_pr1_v4.rb'


def two_biggest(val1,val2,val3)
  
  if (val1 <= val2 && val1 <= val3) then return [val2,val3]
  elsif (val2 <= val3) then return [val1,val3]
  else return [val1, val2]
  end
  
end


def larger_sum_square (val1, val2, val3)
  
  check_pre(val1.int? &&
      val2.int? &&
      val3.int?)
  
  zw_erg = two_biggest(val1, val2, val3)
  return (zw_erg[0]**2 + zw_erg[1]**2)
end


##### Bestimmen sie wie viele Vergleiche ihre Funktion im "worst Case" benötigt
# Da wir 3 Variablen haben und die '>' '<' Verältnisse untereinander bestimmen 
# wollen, müssen wir maximal 3 Vergleiche durchführen.
# 
##### Bestimmen sie was die minimal benötigte Anzahl an Vergleichen ist
# Da wir 2 Variablen zurück geben wollen und den Lösungsraum nach 2 Verlgeichen 
# eindeutig in zwei Bereiche unterteilen können, von denen einer eine eindeutige 
# Lösung ist, reichen zwei Vergleiche im Idealfall. Dieser Fall tritt allerdings 
# nur in einer von drei Möglichkeiten ein.
# 
##### Schreiben sie eine Schachtelung von Konditionaloperatoren, die nur noch 
# die minimale Anzahl von Vergleichen braucht
# 
# def two_biggest(val1,val2,val3)
#  
#  (val1 <= val2 && val1 <= val3) ? ([val2,val3]) : 
#    ( (val2 <= val3) ? ([val1,val3]) : ([val1, val2]) )
#  
# end
# 
##### Gibt es nur ein einziges Programm mit dieser "Effizienz" oder evtl. 
# mehrere äquivalente Programme?
# 
# Die Vergleiche müssen zwar in der selben Reihenfolge ausgeführt werden, 
# allerdings können die Variablen durch einander ersetzt werden, da dies an dem 
# Ergebnis des Programms nichts ändert.
# Dies ist der Fall, weil es egal ist, ob man erst bestimmt, ob val1, val2 oder 
# val3 der kleinste Wert ist und die jeweils anderen beiden zurückgibt und im 
# Nachhinein prüft, welcher der beiden fehlenden Werte kleiner ist.
# Dies ergibt mindestens drei verschiedene Möglichkeiten das Programm zu 
# schreiben.
#