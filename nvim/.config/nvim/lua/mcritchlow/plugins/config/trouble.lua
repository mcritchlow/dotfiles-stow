local ok, trouble = pcall(require, "trouble")

if not ok then
  return
end

trouble.setup {
  auto_close = true, -- if no more errors, we don't need this open
}
