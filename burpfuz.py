from burp import IBurpExtender
from burp import IIntruderPayloadGeneratorFactory
from burp import IIntruderPayloadGenerator

from java.util import List, ArrayList

import random


class BurpExtender(IBurpExtender, IIntruderPayloadGeneratorFactory):
  def registerExtenderCallbacks(self, callbacks):
    self._callbacks = callbacks
    self._helpers = callbacks.getHelpers()

    callbacks.registerIntruderPayloadGeneratorFactory(self)

    return

  def getGeneratorName(self):
    return "BHP Payload GeneratoRRRRRR"

  def createNewInstance(self, attack): 
    return BHPFuzzer(self, attack)

class BHPFuzzer(IIntruderPayloadGenerator):
  def __init__(self, extender, attack):
    self._extender = extender
    self._helpers  = extender._helpers
    self._attack   = attack
    print "BHP Fuzzer initialized"
    self.max_payloads = 10
    self.num_payloads = 0

    return


  def hasMorePayloads(self):
    print "hasMorePayloads called."
    if self.num_payloads == self.max_payloads:
      print "No more payloads."
      return True


  def getNextPayload(self,current_payload):   

    # convert into a string
    payload = "".join(chr(x) for x in current_payload)

    # call our simple mutator to fuzz the POST
    payload = self.mutate_payload(payload)

    # increase the number of fuzzing attempts
    self.num_payloads += 1

    return payload

  def reset(self):

    self.num_payloads = 0

    return

  def mutate_payload(self,original_payload):

    # select a random offset in the payload to mutate
    offset  = random.randint(0,len(original_payload)-1)
    payload = original_payload[:offset]

    # random offset insert a SQL injection attempt    
    payload += "'"      

    # add the remaining bits of the payload 
    payload += original_payload[offset:]

    return payload
