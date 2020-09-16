package cmd

import (
	"strings"

	"github.com/getcouragenow/core-runtime/tool/lang/services"
	"github.com/spf13/cobra"
)

var (
	dir        *string
	template   *string
	prefixName *string
	languages  *string
	full       *bool
)

// flutterCmd represents the flutter command
var flutterCmd = &cobra.Command{
	Use:   "flutter",
	Short: "Generate json and arb files.",
	Long:  `Allows to generate json and arb files already translated any languages wanted.`,
	RunE: func(cmd *cobra.Command, args []string) error {

		if *template == "" {
			return services.GenerateMultiLanguagesArbFilesFromJSONFiles(*dir, *prefixName, "json", "arb", *full)
		}
		return services.GenerateMultiLanguageFilesFromTemplate(*template, *dir, *prefixName, "json", getLanguages(*languages, ","), *full)
	},
}

func init() {
	rootCmd.AddCommand(flutterCmd)
	dir = flutterCmd.Flags().StringP("dir", "d", ".", "Directory where to out and look for files.")
	template = flutterCmd.Flags().StringP("template", "t", "", "Template file path to generate multi languages files.")
	prefixName = flutterCmd.Flags().StringP("prefix", "p", "", "The prefix to add for each file generated.")
	languages = flutterCmd.Flags().StringP("languages", "l", "en,fr,es,de", "Languages list separated by coma.")
	full = flutterCmd.Flags().BoolP("full", "f", false, "Get full detailed out file example to generate json file without arb tags.")
}

func getLanguages(languages, sep string) []string {
	return strings.Split(languages, sep)
}
