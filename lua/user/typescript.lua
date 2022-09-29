local ts_status_ok, typescript = pcall(require, "typescript")
if not ts_status_ok then
  return
end

typescript.setup({})
