json.responders do
  json.array! @responders, partial: 'responders/responder', as: :responder
end