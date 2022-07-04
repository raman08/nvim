local status_ok, sessionlens = pcall(require, "session-lens")
if not status_ok then return end

sessionlens.setup {}
