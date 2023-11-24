using System;

[assembly: WebActivatorEx.PreApplicationStartMethod(
    typeof(WebApplication12.App_Start.DTIControllsPackage), "PreStart")]

namespace WebApplication12.App_Start {
    public static class DTIControllsPackage {
        public static void PreStart() {
            DTIControls.Share.initializePathProvider();
        }
    }
}