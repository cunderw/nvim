local status_ok, scope = pcall(require, "scope")
if not status_ok then
  return
end

scope.setup()
