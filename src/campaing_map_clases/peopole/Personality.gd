class_name Personality

# 6 values for define a personality
# emotional               # how much does someone feel all things
# empaty                  # how much does someone cares abaut someone else
# codicia                 # how much does someone wants to take more thean he has or gain more copwer
# hability                # how much does someone have hability doing thinks in general, the negative will be being "torpe o pelotudo como alberto fernandez"
# gustos_y_forma_de_ser   # the unique way in with someone do thigs and the "espontaniedad cosas espiontaneas que le salen"
# creativity              # how much someone makes new thinks or wants new things such as strategies, new wepons and ect

func _init(emotional_:int,empaty_:int,codicia_:int,hability_:int,gustos_y_forma_de_ser_:int,creativity_:int):

    self.emotional = emotional_
    self.empaty = empaty_
    self.codicia = codicia_
    self.hability = hability_
    self.gustos_y_forma_de_ser = gustos_y_forma_de_ser_
    self.creativity = creativity_