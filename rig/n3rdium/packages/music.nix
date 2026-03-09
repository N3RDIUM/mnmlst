{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # streaming
        pear-desktop

        # musescore
        musescore
        muse-sounds-manager
        
        # production
        crosspipe
        lmms
        zrythm
        qtractor
        audacity
		pavucontrol

        # bridges?
        yabridge
        yabridgectl
        carla

        # plugins
        helm
        dexed
        zynaddsubfx
        odin2
        padthv1
        tunefish
        yoshimi
        drumkv1
        chow-kick
        ardour
        vital
        surge-xt
        bespokesynth
        zam-plugins
        vaporizer2
        infamousPlugins
        lsp-plugins
    ];
}
