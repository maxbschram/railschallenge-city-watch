json.capacity do
  json.Fire Responder.responders_capacity('Fire')
  json.Police Responder.responders_capacity('Police')
  json.Medical Responder.responders_capacity('Medical')
end