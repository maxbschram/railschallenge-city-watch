json.emergencies @emergencies.as_json
json.full_responses [@emergencies.where(full_response: true).count, @emergencies.count]