import Hyprland from "gi://AstalHyprland";
import { Variable, bind } from "astal";

const hyprland = Hyprland.get_default();

// Thanx to https://github.com/rice-cracker-dev/nixos-config/blob/main/modules/extends/candy/home/desktop/shell/ags/config/widgets/HyprlandWidget/index.tsx
const Workspace = ({ id }) => {
	const className = Variable.derive(
		[bind(hyprland, "workspaces"), bind(hyprland, "focusedWorkspace")],
		(workspaces, focused) => {
			const workspace = workspaces.find((w) => w.id === id);

			if (!workspace) {
				return "Workspace";
			}

			const occupied = workspace.get_clients().length > 0;
			const active = focused.id === id;

			return `Workspace ${active ? "Active" : occupied && "Occupied"}`;
		},
	);

	return (
		<box>
			<box hexpand />
			<button
				className={"WorkspaceClick"}
			>
				<box className={className()} />
			</button>
			<box hexpand />
		</box>
	);
};

export default function Workspaces() {
	return (
		<eventbox
			onScroll={(_, e) => {
				hyprland.dispatch("workspace", e.delta_y > 0 ? "+1" : "-1");
			}}
		>
			<box vertical className={"Workspaces"}>
				{[...Array(10).keys()].map((i) => (
					<Workspace id={i + 1} />
				))}
			</box>
		</eventbox>
	);
}
