export default function NixOS({ minified }) {
    // TODO: Turn this into a current window thing.
    // TODO: Basically, if nowin or logo_404, nixos.
    // TODO: Else, window icon.
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
