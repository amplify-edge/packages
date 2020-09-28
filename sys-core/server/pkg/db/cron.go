package db

import (
	"fmt"

	"github.com/robfig/cron/v3"
)

type BackupSchedule struct {
	cron *cron.Cron
}

func NewBackupSchedule() *BackupSchedule {
	return &BackupSchedule{
		cron: cron.New(),
	}
}

func (bs *BackupSchedule) Start() {

	bs.cron.AddFunc("@every 1s", func() {
		fmt.Println("tick every 1 second")
	})

	bs.cron.Start()
}
