local ok, mirror = pcall(require, "custom.github-mirror")
if not ok then
  return "https://github.com/"
end
return mirror
