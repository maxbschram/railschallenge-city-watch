json.emergencies Emergency.all.as_json
json.full_responses [Emergency.where(full_response: true).count, Emergency.count]