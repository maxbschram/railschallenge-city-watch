json.emergency do
  json.responders @responders.collect { |responder| responder.name}
  json.full_response @emergency.full_response
end