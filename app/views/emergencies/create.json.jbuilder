json.emergency do
  json.responders @responders.collect { |responder| responder.name}
  json.full_response @emergency.full_response
  json.code @emergency.code
  json.fire_severity @emergency.fire_severity
  json.police_severity @emergency.police_severity
  json.medical_severity @emergency.medical_severity
end