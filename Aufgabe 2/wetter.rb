#Tests if a tempreture is too cold
#
#zu_kalt? ::= (temp) ::
#Int -> Bool
#
#Test{ (15) => true, (20) => false, (18) => false,
#       ('10')=> Err, (1.3) => Err,}


require_relative '../Extensions/ext_pr1_v4.rb'

def zu_kalt?(temp)

  check_pre(temp.int?)

  temp < 18           # Kurzschreibweise
  
end

#Tests if a tempreture is too hot
#
#zu_warm? ::= (temp) ::
#Int -> Bool ::
#
#Test{ (26) => true, (20) => false, (25) => false,
#       ('10')=> Err, (1.3) => Err,}


def zu_warm?(temp)

  check_pre(temp.int?)
  
  temp > 25            # Kurzschreibweise

end

#Tests if a tempreture is too well
#
#angenehm? ::= (temp) ::
#Int -> Bool ::
#
#Test{
#     (18) => true, (25) => true, (13) => false, (23) => true,
#     ('10') => Err, (10.3) => Err}


def angenehm?(temp)
  
  check_pre(temp.int?)

  !(zu_kalt?(temp) || zu_warm?(temp))
  
  #!(zu_kalt?(temp)) && !(zu_warm?(temp))                     # Erweiterung für 2.4
  
  #zu_kalt?(temp) ? false : zu_warm?(temp) ? false : true     # Erweiterung für 2.4
  
end



#Tests if a tempreture is not well
#
#unangenehm? ::= (temp)
#Int -> Bool ::
#
#Test{
#     (18) => false, (23) => false, (13) => true, (25)=> false,
#     ('10') => Err, (10.3) => Err}


def unangenehm?(temp)
  
  check_pre(temp.int?)
  
  !(angenehm?(temp))
  
end