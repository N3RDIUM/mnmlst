export default function NixOS({ minified }) {
	return (
		<box 
            vertical
            className = {
                minified((value) => value ? "NixOSContainerMini" : "NixOSContainer")
            }
        >
			<icon 
                className = {
                    minified((value) => value ? "NixOSMini" : "NixOS")
                }
                icon="/home/n3rdium/.zenithassets/nixos.svg"
            />
		</box>
	);
}
