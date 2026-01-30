const input = document.getElementById('command-input');
const output = document.getElementById('output');

const commands = {
    'help': 'Available commands: ls, tutor, clear, about, whoami',
    'whoami': 'You are a guest in the Linux Playground.',
    'ls': 'i-installer.desktop  toolbox.desktop  .terminal_tutor.sh (hidden)',
    'about': 'Linux Playground is a CLI-based tool to help new users learn Linux.',
    'tutor': 'Starting Terminal Tutor... [✓] Permissions fixed. Now type "nano i-installer.desktop" to begin.'
};

input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') {
        const cmd = input.value.toLowerCase().trim();
        const response = commands[cmd] || `bash: ${cmd}: command not found`;
        
        output.innerHTML += `<div><span class="prompt">user@linux-playground:~$</span> ${input.value}</div>`;
        if (cmd === 'clear') {
            output.innerHTML = 'Terminal cleared. Type help...';
        } else {
            output.innerHTML += `<div>${response}</div>`;
        }
        
        input.value = '';
        document.getElementById('terminal-body').scrollTop = document.getElementById('terminal-body').scrollHeight;
    }
});
