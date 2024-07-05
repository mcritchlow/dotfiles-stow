local ok, harpoon = pcall(require, "harpoon")

if not ok then
    return
end

local harpoon_repos = {
    "$HOME/projects/ucsd/surfliner/tidewater",
    "$HOME/projects/ucsd/surfliner/comet",
    "$HOME/projects/ucsd/surfliner/shoreline",
    "$HOME/projects/ucsd/surfliner/tidewater",
    "$HOME/projects/ucsd/surfliner/starlight",
    "$HOME/projects/ucsd/surfliner/superskunk",
    "$HOME/projects/ucsd/alma-apbatch",
    "$HOME/projects/ucsd/highfive",
    "$HOME/projects/ucsd/patronload",
    "$HOME/projects/ucsd/damspas",
}

local compose_commands = {
    term = {
        cmds = {
            "docker-compose build && docker-compose up",
            "docker-compose down -v",
        }
    }
}

local harpoon_projects = {}
for _, repo in pairs(harpoon_repos) do
    harpoon_projects[repo] = compose_commands
end


harpoon.setup({
    global_settings = {
        enter_on_sendcmd = true
    },
    projects = harpoon_projects
})
